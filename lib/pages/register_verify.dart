import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otp_count_down/otp_count_down.dart';

import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../controllers/user_controller.dart';
import '../repository/user_repository.dart';
import '../generated/l10n.dart';

class RegisterVerifyWidget extends StatefulWidget {
  @override
  _RegisterVerifyWidgetState createState() => _RegisterVerifyWidgetState();
}

class _RegisterVerifyWidgetState extends StateMVC<RegisterVerifyWidget> {
  bool _status = true;
  UserController _con;
  dynamic smsCode = {};

  String _countDown = "";
  OTPCountDown _otpCountDown;
  final int _otpTimeInMS = 1000 * 1 * 60; //60s = 1min

  TextEditingController _con1 = TextEditingController(),
      _con2 = TextEditingController();

  _RegisterVerifyWidgetState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
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
            top: config.App(context).appVerticalPadding(20),
            child: Container(
              width: config.App(context).appHorizontalPadding(84),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    S.of(context).veri_code,
                    style: Theme.of(context).textTheme.headline5.merge(
                        TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _status
                        ? S.of(context).please_input_phone
                        : S.of(context).sent_a_veri_code,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .merge(TextStyle(color: Colors.grey[700])),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: config.App(context).appVerticalPadding(35),
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
                  padding: EdgeInsets.all(30),
                  width: config.App(context).appHorizontalPadding(85),
                  child: Form(
                    key: _con.loginFormKey,
                    child: Column(
                      children: <Widget>[
                        _status
                            ? Container(
                                child: TextFormField(
                                  controller: _con1,
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(fontSize: 20),
                                  onSaved: (input) => _con.user.phone = input,
                                  validator: (input) => input.length < 9
                                      ? S.of(context).phone_10_digits
                                      : null,
                                  decoration: InputDecoration(
                                    prefix: Text(
                                      "(+86) ",
                                      style: TextStyle(
                                          color: Theme.of(context).hintColor),
                                    ),
                                    labelText: S.of(context).phone_number,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).primaryColor),
                                    contentPadding: EdgeInsets.all(6),
                                  ),
                                ),
                              )
                            : Container(
                                child: TextFormField(
                                  controller: _con2,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(fontSize: 20),
                                  onSaved: (input) =>
                                      _con.user.verifyCode = input,
                                  validator: (input) => input.length != 6
                                      ? S.of(context).veri_code_6_digits
                                      : null,
                                  decoration: InputDecoration(
                                    hintText: S.of(context).enter_your_code,
                                    // labelText: "Verify Code",
                                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).primaryColor),
                                    contentPadding: EdgeInsets.all(6),
                                  ),
                                ),
                              ),
                        SizedBox(height: 10),
                        Text(_countDown.toString()),
                        (!_status && _countDown == "")
                            ? Container(
                                width: config.App(context)
                                    .appHorizontalPadding(84),
                                alignment: Alignment.centerRight,
                                child: FlatButton(
                                  padding: EdgeInsets.all(5),
                                  onPressed: () {
                                    setState(() {
                                      _status = true;
                                    });
                                  },
                                  child: Text(
                                    S.of(context).resend,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .merge(
                                            TextStyle(color: Colors.grey[700])),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(height: 15),
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
                                _status
                                    ? S.of(context).send_code
                                    : S.of(context).verify,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                if (_status) {
                                  if (_con.loginFormKey.currentState
                                      .validate()) {
                                    _con.loginFormKey.currentState.save();
                                    smsCode =
                                        await _con.getSmsCode(_con.user.phone);
                                    print(smsCode.toString());
                                    if (smsCode['data']['data']['SendStatusSet']
                                                [0]['Code']
                                            .toString() ==
                                        "Ok") {
                                      registerPhone.value = _con.user.phone;
                                      _startCountDown();
                                      setState(() {
                                        _countDown = " ";
                                        _status = !_status;
                                      });
                                    } else {
                                      _con.scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content:
                                            Text(S.of(context).incorrect_phone),
                                      ));
                                    }
                                  }
                                } else {
                                  if (_con.loginFormKey.currentState
                                      .validate()) {
                                    _con.loginFormKey.currentState.save();
                                    if (smsCode['data']['code'].toString() ==
                                        _con.user.verifyCode) {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil('/register',
                                              (Route<dynamic> route) => true);
                                    } else {
                                      _con.scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            S.of(context).incorrect_veri_code),
                                      ));
                                    }
                                  }
                                }

                                // _con.registerVerify();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: config.App(context).appHorizontalPadding(84),
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     '/register_verify', (Route<dynamic> route) => true);
                      Navigator.pop(context);
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

  void _startCountDown() {
    _otpCountDown = OTPCountDown.startOTPTimer(
      timeInMS: _otpTimeInMS,
      currentCountDown: (String countDown) {
        setState(() {
          _countDown = countDown;
        });
      },
      onFinish: () {
        print("Count down finished!");
        setState(() {
          _countDown = "";
        });
      },
    );
  }
}
