import 'package:flutter_scale/screens/products/product_add.dart';
import 'package:flutter_scale/screens/products/product_datail.dart';
import 'package:flutter_scale/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_scale/screens/drawerpage/about_screen.dart';
import 'package:flutter_scale/screens/drawerpage/contact_screen.dart';
import 'package:flutter_scale/screens/drawerpage/info_screen.dart';
import 'package:flutter_scale/screens/login/login_screen.dart';
import 'package:flutter_scale/screens/products/product_update.dart';
import 'package:flutter_scale/screens/register/register_screen.dart';
import 'package:flutter_scale/screens/welcome/welcome_screen.dart';

class AppRouter {
  // Router Map Key
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String register = 'register';
  static const String dashboard = 'dashboard';
  static const String info = 'info';
  static const String contact = 'contact';
  static const String about = 'about';
  static const String productDetail = 'productDetail';
  static const String productAdd = 'productAdd';
  static const String productUpdate = 'productUpdate';

  // Router Map
  static get routes => {
    welcome: (context) => WelcomeScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    dashboard: (context) => DashboardScreen(),
    info: (context) => InfoScreen(),
    contact: (context) => ContactScreen(),
    about: (context) => AboutScreen(),
    productDetail: (context) => ProductDetail(),
    productAdd: (context) => ProductAddScreen(),
    productUpdate: (context) => ProductUpdateScreen(),
  };
}