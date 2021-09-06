import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../controllers/user_controller.dart';

class ForgotPasswordChangeWidget extends StatefulWidget {
  @override
  _ForgotPasswordChangeWidgetState createState() =>
      _ForgotPasswordChangeWidgetState();
}

class _ForgotPasswordChangeWidgetState
    extends StateMVC<ForgotPasswordChangeWidget> {
  UserController _con;
  _ForgotPasswordChangeWidgetState() : super(UserController()) {
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
                    "Reset your password",
                    style: Theme.of(context).textTheme.headline5.merge(
                        TextStyle(color: Theme.of(context).primaryColor)),
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
              padding: EdgeInsets.all(30),
              width: config.App(context).appHorizontalPadding(85),
              child: Form(
                key: _con.loginFormKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20),
                        onSaved: (input) => _con.user.password = input,
                        obscureText: _con.hidePassword,
                        validator: (input) => input.length < 4
                            ? "Should be more than 4 characters."
                            : null,
                        decoration: InputDecoration(
                          labelText: "New Password",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor),
                          contentPadding: EdgeInsets.all(6),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20),
                        obscureText: _con.hidePassword,
                        validator: (input) => input.length < 4
                            ? "Should be more than 4 characters."
                            : null,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor),
                          contentPadding: EdgeInsets.all(6),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
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
                            "Confirm",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            _con.forgotPasswordChange();
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
