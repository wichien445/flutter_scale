import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/components/already_have_an_account_acheck.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  // Form Globalkey
  final _formKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้เก็บค่า username และ password
  String? _email, _password;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            validator: (value) {
              if(value!.isEmpty) {
                return "Please fill email";
              }
              return null;
            },
            onSaved: (value) {
              _email = value!;
            },
            decoration: InputDecoration(
              hintText: "Email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              validator: (value) {
                if(value!.isEmpty) {
                  return "Please fill password";
                }
                return null;
              },
              onSaved: (value) {
                _password = value!;
              },
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () async {
                if(_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // logger.i("Username: $_username, Password: $_password");

                  //เรียกใช้งาน API Login
                  var response = await CallAPI().loginAPI(
                    {
                      'email' : _email,
                      'password' : _password,
                    }
                  );

                  var body = jsonDecode(response);
                  if(body['status'] == 'ok') {

                    // Create SharedPreferences Instance
                    final SharedPreferences prefs = await SharedPreferences.getInstance();

                    // บันทึก token ลง SharedPreferences
                    prefs.setString('token', body['token']);
                    prefs.setString('email', body['user']['email']);
                    prefs.setString('firstname', body['user']['firstname']);
                    prefs.setString('lastname', body['user']['lastname']);
                    prefs.setInt('step', 2);

                    // แจ้งว่า Login สำเร็จ
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(child: Text(body['message'])),
                        backgroundColor: Colors.green,
                      )
                    );
                    // ส่งไปหน้า Dashboard
                    Navigator.pushReplacementNamed(context, AppRouter.dashboard);
                  }else {
                    //แจ้งเตือน
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(child: Text(body['message'])),
                        backgroundColor: Colors.red,
                      )
                    );
                  }
                }
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.pushReplacementNamed(context, AppRouter.register);
            },
          ),
        ],
      ),
    );
  }
}
