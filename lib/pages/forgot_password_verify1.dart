import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../controllers/user_controller.dart';

class ForgotPasswordVerifyWidget extends StatefulWidget {
  @override
  _ForgotPasswordVerifyWidgetState createState() =>
      _ForgotPasswordVerifyWidgetState();
}

class _ForgotPasswordVerifyWidgetState
    extends StateMVC<ForgotPasswordVerifyWidget> {
  UserController _con;
  _ForgotPasswordVerifyWidgetState() : super(UserController()) {
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
                    "Verification Code",
                    style: Theme.of(context).textTheme.headline5.merge(
                        TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Sent a verification code to verify your account",
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
            child: Container(
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
                        onSaved: (input) => _con.user.verifyCode = input,
                        validator: (input) => input.length != 6
                            ? "Verification Code should be 6 digits."
                            : null,
                        decoration: InputDecoration(
                          hintText: "Enter your Verification Code",
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
                    Container(
                      width: config.App(context).appHorizontalPadding(84),
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        padding: EdgeInsets.all(5),
                        onPressed: () {
                          print("Resend!!!");
                        },
                        child: Text(
                          "Resend",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .merge(TextStyle(color: Colors.grey[700])),
                        ),
                      ),
                    ),
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
                            "Verify",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            _con.forgotPasswordVerify();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
