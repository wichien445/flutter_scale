import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/screens/bottomnavpage/home_screen.dart';
import 'package:flutter_scale/screens/bottomnavpage/notification_screen.dart';
import 'package:flutter_scale/screens/bottomnavpage/profile_screen.dart';
import 'package:flutter_scale/screens/bottomnavpage/report_screen.dart';
import 'package:flutter_scale/screens/bottomnavpage/setting_screen.dart';
import 'package:flutter_scale/themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // ส่วนการโหลดสลับข้อมูลใน bottomNavigationBar

  // สร้างตัวแปรเก็บ title ของแต่ละหน้า
  String _title = 'Flutter Scale';

  // สร้างตัวแปรเก็บ index ของแต่ละหน้า
  int _currentIndex = 0;

  // สร้าง List ของแต่ละหน้า
  final List<Widget> _children = [
    HomeScreen(),
    ReportScreen(),
    NotificationScreen(),
    SettingScreen(),
    ProfileScreen()
  ];

  // ฟังชั่นสำหรับเปลี่ยนหน้า โดยรับค่าจาก index จากการกดที่ bottomNavigationBar
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0: _title = 'Home'; break;
        case 1: _title = 'Report'; break;
        case 2: _title = 'Notification'; break;
        case 3: _title = 'Setting'; break;
        case 4: _title = 'Profile'; break;
        default: _title = 'Flutter Scale';
      }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.orange[300],
                  ),
                  accountName: Text('Wichien Naktong-in'),
                  accountEmail: Text('wichien445@hotmail.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  otherAccountsPictures: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                  ],
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text(AppLocalizations.of(context)!.menu_info, style: TextStyle(fontSize: 18),),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRouter.info);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(AppLocalizations.of(context)!.menu_about, style: TextStyle(fontSize: 18),),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRouter.about);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text(AppLocalizations.of(context)!.menu_contact, style: TextStyle(fontSize: 18),),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRouter.contact);
                  },
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text(AppLocalizations.of(context)!.menu_logout, style: TextStyle(fontSize: 18),),
                  onTap: _logout,
                ),
                ],
              ),
            )
          ],
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryDark,
        unselectedItemColor: secondaryText,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: AppLocalizations.of(context)!.menu_home
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart_outlined),
              label: AppLocalizations.of(context)!.menu_report
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              label: AppLocalizations.of(context)!.menu_notification
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: AppLocalizations.of(context)!.menu_setting
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: AppLocalizations.of(context)!.menu_profile
          ),
        ]
      ),
    );
  }
}