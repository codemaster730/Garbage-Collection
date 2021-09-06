import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';

import '../helpers/helper.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as user_repository;
import '../generated/l10n.dart';

class UserController extends ControllerMVC {
  User user = new User();

  int selectedPropertyId = 0;
  bool hidePassword = true;
  bool loading = false;
  bool isEdit = false;
  String price = "0";
  // File collector_image;

  GlobalKey<FormState> loginFormKey;
  GlobalKey<FormState> selectPropertyFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  OverlayEntry loader;

  UserController() {
    loader = Helper.overlayLoader(context, Colors.grey);
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void login() async {
    FocusScope.of(context).unfocus();
    loader = Helper.overlayLoader(context, Colors.grey);
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);

      user_repository.login(user).then((value) {
        // print("login ok" + value.auth.toString());
        if (value != null && value.auth != false) {
          // print("logined user:" + value.toString());
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => true,
              arguments: 0);
        } else {
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text(S.of(context).wrong_email_or_password),
          ));
        }
      }).catchError((e) {
        loader.remove();
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).this_account_not_exist),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  void updateProfile(File img) async {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      print("~~~~~~~~~~~~~~~~~~");
      print(user.toMap().toString());

      user_repository.updateProfile(user, img).then((res) async {
        final value = await res.stream.bytesToString();

        Map mapRes = json.decode(value);
        print(mapRes['message']);
        if (mapRes['success'] == true) {
          user_repository.updateCurrentUser(mapRes['data']);
          user_repository.currentUser.value = User.fromJSON(mapRes['data']);
        }
        Fluttertoast.showToast(msg: mapRes['message']);
        setState(() {
          isEdit = false;
        });
      }).catchError((e) {
        loader.remove();
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  Future<dynamic> getSmsCode(String phone) async {
    Overlay.of(context).insert(loader);
    final String url =
        '${GlobalConfiguration().getValue('api_base_url')}send_register_sms_code?phone=+86$phone';
    final client = new http.Client();
    final response = await client.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    Helper.hideLoader(loader);
    return json.decode(response.body);
  }

  void forgotPasswordSend() async {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/forgot_password_verify', (Route<dynamic> route) => true);
    }
  }

  void forgotPasswordVerify() async {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/forgot_password_change', (Route<dynamic> route) => true);
    }
  }

  void forgotPasswordChange() async {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => true);
    }
  }

  void register() async {
    // FocusScope.of(context).unfocus();
    // if (loginFormKey.currentState.validate()) {
    //   loginFormKey.currentState.save();
    //   Navigator.of(context).pushNamedAndRemoveUntil(
    //       '/register_verify', (Route<dynamic> route) => true);
    // }
    FocusScope.of(context).unfocus();
    loader = Helper.overlayLoader(context, Colors.grey);
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      // await Helper.of(context)
      //     .getAddressName('${user.long.toString()},${user.lat.toString()}')
      //     .then((value) => user.address = value);
      user_repository.register(user).then((value) {
        if (value != null && value.auth != false) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => true,
              arguments: 0);
        } else {
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text("This account was already existed."),
          ));
        }
      }).catchError((e) {
        loader.remove();
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text("This account could not register"),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  void registerVerify() async {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/home', (Route<dynamic> route) => true,
          arguments: 0);
    }
  }

  void changePassword(String password, String phone) async {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      Overlay.of(context).insert(loader);

      user_repository.changePassword(password, phone).then((res) {
        if (res['success'] == false) {
          Fluttertoast.showToast(msg: res["message"]);
        } else {
          Fluttertoast.showToast(msg: res["message"]);
        }
        Navigator.pop(context);
      }).catchError((e) {
        loader.remove();
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }
}
