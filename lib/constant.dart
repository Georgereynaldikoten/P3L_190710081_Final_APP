// ---------STRINGS---------
import 'package:flutter/material.dart';

const baseURL = 'http://192.168.137.1:8000/api/';
const loginURL = baseURL + 'login';
const registerURL = baseURL + 'register';
const logoutURL = baseURL + 'logout';
//get user pass middleware
const userURL = baseURL + 'user';
const timetableURL = baseURL + 'timetable';

// ---------ERRORS---------
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';

// Title Decoration
Text kTitleDecoration(String label) {
  return Text(label, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
}
Text kTitleDecorationsmall(String label) {
  return Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),);
}
// --- input decoration
InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black))
    );
}

// button

TextButton kTextButton(String label, Function onPressed){
  return TextButton(
    child: Text(label, style: TextStyle(color: Colors.white),),
    style: ButtonStyle(
      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
      padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(vertical: 10))
    ),
    onPressed: () => onPressed(),
  );
}

// loginRegisterHint
Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
        child: Text(label, style:TextStyle(color: Colors.blue)),
        onTap: () => onTap()
      )
    ],
  );
}

const String invalidEmailError = 'Please enter a valid email';
const String emptyEmailError = 'Please enter an email';
const String emptyPasswordError = 'Please enter a password';
const String invalidPasswordError = 'Password must be at least 6 characters';
const String emptyNameError = 'Please enter a name';
const String emptyLevelError = 'Please enter a level';
const String emptyConfirmPasswordError = 'Please enter a confirm password';
const String invalidConfirmPasswordError = 'Confirm password must be at least 6 characters';
const String matchPasswordError = 'Password and Confirm Password must be same';
const String invalidNameError = 'Please enter a valid name';
const String invalidLevelError = 'Please enter a valid level';
const String invalidLoginError = 'Invalid email or password';
const String invalidRegisterError = 'Invalid email or password';
const String invalidTokenError = 'Invalid token';
const String invalidLogoutError = 'Invalid logout';
const String invalidEmailPasswordError = 'Invalid email or password';
const String invalidEmailRegisterError = 'Invalid email or password';
const String invalidEmailLogoutError = 'Invalid email or password';
const String invalidEmailTokenError = 'Invalid email or password';
const String invalidEmailLoginError = 'Invalid email or password';
const String invalidEmailRegisterTokenError = 'Invalid email or password';
const String invalidEmailLoginTokenError = 'Invalid email or password';
const String invalidEmailLogoutTokenError = 'Invalid email or password';
const String invalidEmailPasswordTokenError = 'Invalid email or password';
const String invalidEmailRegisterLoginError = 'Invalid email or password';
const String invalidEmailRegisterLogoutError = 'Invalid email or password';
const String invalidEmailLoginLogoutError = 'Invalid email or password';
const String invalidEmailRegisterLoginLogoutError = 'Invalid email or password';
const String invalidEmailPasswordRegisterError = 'Invalid email or password';
const String invalidEmailPasswordLoginError = 'Invalid email or password';
const String invalidEmailPasswordLogoutError = 'Invalid email or password';
const String invalidEmailPasswordRegisterTokenError =
    'Invalid email or password';
