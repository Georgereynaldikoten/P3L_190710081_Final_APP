import 'dart:io';
import 'package:flutter_application_1/models/api_response.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'login.dart';
import '../constant.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user;
  bool loading = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  TextEditingController txtNameController = TextEditingController();
  TextEditingController txtEmailController = TextEditingController();
  TextEditingController txtLevelController = TextEditingController();

 
  // get user detail
  void getUser() async {
    ApiResponse response = await getUserDetail();
    if(response.error == null) {
      setState(() {
        user = response.data as User;
        loading = false;
        txtNameController.text = user!.name ?? '';
        txtEmailController.text = user!.email ?? '';
        txtLevelController.text = user!.level ?? '';
        
      });
    }
    else if(response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false)
      });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }

  //update profile
  void updateProfile() async {
    ApiResponse response = await updateUser(txtNameController.text);
      setState(() {
        loading = false;
      });
    if(response.error == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.data}')
      ));
    }
    else if(response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false)
      });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return loading ? Center(child: CircularProgressIndicator(),) :
    Padding(
      padding: EdgeInsets.only(top: 40, left: 40, right: 40),
      child: ListView(
        children: [
          Center(
            child: Text('Profile', style: TextStyle(fontSize: 30),),

          ),
          SizedBox(height: 20,),
          TextFormField(
            decoration: kInputDecoration('Name'),
            controller: txtNameController,
            enabled: false,
          ),
          SizedBox(height: 20,),
          TextFormField(
            decoration: kInputDecoration('Email'),
            controller: txtEmailController,
            enabled: false,
          ),
          SizedBox(height: 20,),
          TextFormField(
            decoration: kInputDecoration('Level'),
            controller: txtLevelController,
            enabled: false,
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            child: Text('Change Password'),
            onPressed: (){
              Navigator.of(context).pushNamed('/change-password');
            },
          ),
         
        ],
      ),
    );
  }
}