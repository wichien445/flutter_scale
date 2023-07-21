// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/components/already_have_an_account_acheck.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/themes/colors.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // Form Globalkey
  final _formKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้เก็บค่า username และ password
  String? _firstname, _lastname, _email, _password;
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
                return "Please fill firstname";
              }
              return null;
            },
            onSaved: (value) {
              _firstname = value!;
            },
            decoration: InputDecoration(
              hintText: "Firstname",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              validator: (value) {
                if(value!.isEmpty) {
                  return "Please fill lastname";
                }
                return null;
              },
              onSaved: (value) {
                _lastname = value!;
              },
              decoration: InputDecoration(
                hintText: "Lastname",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
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
                  var response = await CallAPI().registerAPI(
                    {
                      'firstname' : _firstname,
                      'lastname' : _lastname,
                      'email' : _email,
                      'password' : _password,
                    }
                  );

                  var body = jsonDecode(response.body);
                  if(body['status'] == 'ok') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(child: Text(body['message'])),
                        backgroundColor: Colors.green,
                      )
                    );
                    // ส่งไปหน้า Dashboard
                    Navigator.pushReplacementNamed(context, AppRouter.login);
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
                "ลงทะเบียน".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.pushNamed(context, AppRouter.login);
            },
          ),
        ],
      ),
    );
  }
}