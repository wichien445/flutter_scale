// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/provider/locale_provider.dart';
import 'package:flutter_scale/themes/colors.dart';
import 'package:flutter_scale/themes/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // สร้างตัวแปรไว้เก็บค่าจาก SharedPreferences
  String? _firstname, _lastname, _email;

  // Get User Profile
  getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstname = prefs.getString('firstname');
      _lastname = prefs.getString('lastname');
      _email = prefs.getString('email');
    });
  }

  //Method Logout
  void _logout() async {
    // Create SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ลบค่า step ออกจาก SharedPreferences
    prefs.clear();
    // Set Step to 1
    prefs.setInt('step', 1);
    // กลับไปหน้า Welcome
    Navigator.pushNamedAndRemoveUntil(context, AppRouter.login, (route) => false);
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              _buildHeader(),
              _buildListMenu(),
            ],
          )
        ],
      ),
    );
  }

  // _buildHeader widget
  Widget _buildHeader() {
    return Container(
      height: 230,
      decoration: BoxDecoration(color: primaryDark),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppLocalizations.of(context)!.hello, style: TextStyle(color: Colors.white, fontSize: 20)),
          SizedBox(height: 10),
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
          SizedBox(height: 10),
          Text(
            '$_firstname $_lastname',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            '$_email',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // _buildListMenu widget
  Widget _buildListMenu() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text(AppLocalizations.of(context)!.menu_profile),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.password),
          title: Text(AppLocalizations.of(context)!.menu_changepass),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Text(AppLocalizations.of(context)!.menu_changelang),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {
            // Create alert dialog select language
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    AppLocalizations.of(context)!.menu_changelang,
                  ),
                  content: SingleChildScrollView(
                    child: Consumer<LocaleProvider>(
                      builder: (context, provider, child){
                        return ListBody(
                          children: [
                            InkWell(
                              child: Text('English'),
                              onTap: () {
                                provider.changeLocale(Locale('en'));
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              child: Text('Thai'),
                              onTap: () {
                                provider.changeLocale(Locale('th'));
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              child: Text('Chinese'),
                              onTap: () {
                                provider.changeLocale(Locale('zh'));
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      }         
                    ),
                  ),
                );
              },
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text(AppLocalizations.of(context)!.menu_setting),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text(AppLocalizations.of(context)!.menu_logout),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: _logout,
        ),
      ],
    );
  }
}
