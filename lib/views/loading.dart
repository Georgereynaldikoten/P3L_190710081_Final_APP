import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/services/user_service.dart';
import 'package:flutter_application_1/views/home.dart';
import 'package:flutter_application_1/models/api_response.dart';


import 'login.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void _loadUserInfo() async {
    String token = await getToken();
    String level = await getLevel();
   if(token == '' || level == ''){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false);
    }
    else {
      ApiResponse response = await getUserDetail();
      if (response.error == null){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);
      }
      else if (response.error == unauthorized){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false);
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
      }
    }
  }

  @override
  void initState() {
    _loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: 
      Center(
        //Make CircularProgressIndicator in center with image with duration 3 seconds
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Image.asset(
              'assets/images/LOGO.jpg',
              width: 200,
              height: 200,
              
              
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
             //Duration of progress indicator is 5 seconds
              value: 1.0,
              strokeWidth: 5.0,
            ),
          ],
        ),

      ),
    );
  }
}
