import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'pages/login.dart';
import 'pages/forgot_password.dart';
import 'pages/change_password.dart';
import 'pages/forgot_password_verify.dart';
import 'pages/forgot_password_change.dart';
import 'pages/register.dart';
import 'pages/register_verify.dart';
import 'pages/home.dart';
import 'pages/search_detail.dart';
import 'pages/order_detail.dart';
import 'pages/map_detail.dart';
import 'models/route_argument.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeWidget(currentTab: args));
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginWidget());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterWidget());
      case '/register_verify':
        return MaterialPageRoute(builder: (_) => RegisterVerifyWidget());
      case '/forgot_password':
        // return MaterialPageRoute(builder: (_) => ForgotPasswordWidget());
        return MaterialPageRoute(
            builder: (_) =>
                ChangePasswordScreen(routeArgument: args as RouteArgument));
      case '/forgot_password_verify':
        return MaterialPageRoute(builder: (_) => ForgotPasswordVerifyWidget());
      case '/forgot_password_change':
        return MaterialPageRoute(builder: (_) => ForgotPasswordChangeWidget());
      case '/search':
        return MaterialPageRoute(builder: (_) => SearchDetailWidget());
      case '/mapDetail':
        return MaterialPageRoute(builder: (_) => MapDetailWidget());
      case '/orderDetail':
        return MaterialPageRoute(
            builder: (_) => OrderDetailWidget(index: args));
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
