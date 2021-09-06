import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../controllers/user_controller.dart';
import '../generated/l10n.dart';
import '../repository/user_repository.dart';

import 'package:amap_location/amap_location.dart' as amapLoc;

class RegisterWidget extends StatefulWidget {
  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends StateMVC<RegisterWidget> {
  UserController _con;
  _RegisterWidgetState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    // try {
    //   if (Platform.isAndroid) {
    //     amapLoc.AMapLocationClient.setApiKey(
    //         config.ConstConfig.amapApiKeys.androidKey);
    //   } else if (Platform.isIOS) {
    //     amapLoc.AMapLocationClient.setApiKey(
    //         config.ConstConfig.amapApiKeys.iosKey);
    //   }
    // } on PlatformException {
    //   print('Failed to get platform version');
    // }
    //first run page
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Positioned(
            top: config.App(context).appVerticalPadding(15),
            child: Container(
              width: config.App(context).appHorizontalPadding(84),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.headline5.merge(
                        TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: config.App(context).appVerticalPadding(20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(40),
                  width: config.App(context).appHorizontalPadding(85),
                  child: Form(
                    key: _con.loginFormKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 20),
                            onSaved: (input) => _con.user.name = input,
                            validator: (input) => input.length < 2
                                ? S.of(context).name_should_be_2
                                : null,
                            decoration: InputDecoration(
                              labelText: S.of(context).name,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                              contentPadding: EdgeInsets.all(6),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 20),
                            onSaved: (input) => _con.user.password = input,
                            obscureText: _con.hidePassword,
                            validator: (input) => input.length < 3
                                ? S.of(context).should_be_more_than_3_characters
                                : null,
                            decoration: InputDecoration(
                              labelText: S.of(context).password,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                              contentPadding: EdgeInsets.all(6),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 20),
                            obscureText: _con.hidePassword,
                            validator: (input) => input.length < 4
                                ? S.of(context).should_be_more_than_3_characters
                                : null,
                            decoration: InputDecoration(
                              labelText: S.of(context).confirm_password,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                              contentPadding: EdgeInsets.all(6),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: config.App(context).appHorizontalPadding(50),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red.withAlpha(200),
                              borderRadius: BorderRadius.circular(36),
                            ),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36.0),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                S.of(context).confirm,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                _con.user.phone = registerPhone.value;

                                // ServiceStatus serviceStatus =
                                //     await Permission.location.serviceStatus;
                                // if (serviceStatus != ServiceStatus.enabled) {
                                //   Fluttertoast.showToast(msg: '请先开启位置服务');
                                //   return;
                                // }
                                // if (!await Permission.location
                                //     .request()
                                //     .isGranted) {
                                //   Fluttertoast.showToast(msg: '无定位权限');
                                //   return;
                                // }
                                // await _determinePosition().then((value) {
                                //   setState(() {
                                //     _con.user.lat = value.latitude;
                                //     _con.user.long = value.longitude;
                                //   });
                                // });
                                _con.user.lat = 39.916668;
                                _con.user.long = 116.383331;
                                _con.user.address = "默认地址";
                                _con.register();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: config.App(context).appHorizontalPadding(84),
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login', (Route<dynamic> route) => true);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).primaryColor,
                          size: 16,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          S.of(context).i_have_account_back_to_login,
                          style: Theme.of(context).textTheme.subtitle2.merge(
                              TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<amapLoc.AMapLocation> _determinePosition() async {
    // bool serviceEnabled;
    // LocationPermission permission;
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled.');
    // }

    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     return Future.error('Location permissions are denied');
    //   }
    // }

    // if (permission == LocationPermission.deniedForever) {
    //   return Future.error(
    //       'Location permissions are permanently denied, we cannot request permissions.');
    // }
    // return await Geolocator.getCurrentPosition();

    await amapLoc.AMapLocationClient.startup(new amapLoc.AMapLocationOption(
        desiredAccuracy: amapLoc.CLLocationAccuracy.kCLLocationAccuracyBest));
    return await amapLoc.AMapLocationClient.getLocation(true);
  }
}
