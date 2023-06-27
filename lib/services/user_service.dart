import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/api_response.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//Login pass token

Future<ApiResponse> login(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(loginURL),
    
     headers: {'Accept': 'application/json' }, 
     body: {'email': email,'password': password,}

     );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors['errors.keys.elementAt(0)'][0];
        break;
      case 401:
        apiResponse.error = invalidLoginError;
        break;

      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//Register
Future<ApiResponse> register(
    String name, String level, String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(registerURL), headers: {
      'Accept': 'application/json'
    }, body: {
      'name': name,
      'level': level,
      'email': email,
      'password': password,
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors['errors.keys.elementAt(0)'][0];
        break;
      case 401:
        apiResponse.error = invalidRegisterError;
        break;

      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//User
Future<ApiResponse> getUserDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    int userId = await getUserId();
    String userURL = baseURL + 'user/$userId';
    final response = await http.get(
      Uri.parse(userURL), 
      headers: {
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors['errors.keys.elementAt(0)'][0];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//update user
Future<ApiResponse> updateUser(String name) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(
      Uri.parse(userURL),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, 
      body: name != null ? {
        'name': name,
      } : {
        'name': name
      });
      // user can update his/her name or name and image

    switch(response.statusCode) {
      case 200:
        apiResponse.data =jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        print(response.body);
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}


//get token
Future<String> getToken() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

//Get Access Token
Future<String> getAccessToken() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('access_token') ?? '';
}

//Get Level
Future<String> getLevel() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('level') ?? '';
}

/// get user id
Future<int> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userId') ?? 0;
}

//Logout
Future<bool> logout() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.remove('token');
}