import 'dart:async';

import 'package:flutter/material.dart';
import '../helpers/app_config.dart' as config;
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/user_repository.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  String checkPref;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadData() async {
    // Timer(Duration(seconds: 2), () {
    //   Navigator.of(context).pushReplacementNamed('/login', arguments: 0);
    // });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checkPref = prefs.getString('current_user');
    if (checkPref != null) {
      await getCurrentUser();
    }
    // setState(() {
    //   setState(() {
    if (checkPref == null) {
      Timer(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacementNamed('/login');
      });
    } else {
      Timer(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacementNamed('/home', arguments: 0);
      });
    }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/img/splash1.png",
                width: config.App(context).appHorizontalPadding(40),
                fit: BoxFit.cover,
              ),
              SizedBox(height: 50),
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
              ),
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: Stack(
    //     alignment: AlignmentDirectional.topCenter,
    //     children: <Widget>[
    //       Positioned(
    //         top: config.App(context).appVerticalPadding(15),
    //         child: Container(
    //           width: config.App(context).appHorizontalPadding(90),
    //           height: config.App(context).appVerticalPadding(90),
    //           decoration: BoxDecoration(
    //             image: DecorationImage(
    //               image: AssetImage(
    //                 "assets/img/splash1.png",
    //               ),
    //               fit: BoxFit.fitWidth,
    //             ),
    //           ),
    //         ),
    //       ),
    //       CircularProgressIndicator(
    //         valueColor:
    //             AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
    //       ),
    //       Positioned(
    //         top: config.App(context).appVerticalPadding(5),
    //         child: Container(
    //           width: config.App(context).appHorizontalPadding(40),
    //           height: config.App(context).appVerticalPadding(40),
    //           decoration: BoxDecoration(
    //             image: DecorationImage(
    //               image: AssetImage(
    //                 "assets/img/logo.png",
    //               ),
    //               fit: BoxFit.fitWidth,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
