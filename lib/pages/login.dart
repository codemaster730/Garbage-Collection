import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../controllers/user_controller.dart';
import '../generated/l10n.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends StateMVC<LoginWidget> {
  UserController _con;
  _LoginWidgetState() : super(UserController()) {
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
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: _con.scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned(
              top: config.App(context).appVerticalPadding(5),
              child: Container(
                width: config.App(context).appHorizontalPadding(30),
                height: config.App(context).appVerticalPadding(30),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/img/logo.png",
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Positioned(
              top: config.App(context).appVerticalPadding(33),
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
                          // Container(
                          //   child: TextFormField(
                          //     keyboardType: TextInputType.text,
                          //     style: TextStyle(fontSize: 20),
                          //     onSaved: (input) => _con.user.email = input,
                          //     validator: (input) => !input.contains('@')
                          //         ? S.of(context).should_be_a_valid_email
                          //         : null,
                          //     initialValue: "col123@gmail.com",
                          //     decoration: InputDecoration(
                          //       // hintText: "‎+8618411632866",
                          //       labelText: S.of(context).email,
                          //       floatingLabelBehavior:
                          //           FloatingLabelBehavior.always,
                          //       labelStyle: TextStyle(
                          //           fontSize: 20,
                          //           color: Theme.of(context).primaryColor),
                          //       contentPadding: EdgeInsets.all(6),
                          //     ),
                          //   ),
                          // ),
                          Container(
                            child: TextFormField(
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
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              onSaved: (input) => _con.user.password = input,
                              style: TextStyle(fontSize: 20),
                              obscureText: _con.hidePassword,
                              validator: (input) => input.length < 3
                                  ? S.of(context).should_be_more_than_3_letters
                                  : null,
                              // initialValue: "123123",
                              decoration: InputDecoration(
                                // hintText: "...",
                                labelText: S.of(context).password,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor),
                                contentPadding: EdgeInsets.all(6),
                                // prefixIcon: Icon(
                                //   Icons.lock_outlined,
                                //   size: 30,
                                //   color: Theme.of(context).primaryColor,
                                // ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: config.App(context).appHorizontalPadding(84),
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              onPressed: () {
                                print("forgot password!!!");
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/forgot_password_verify',
                                    (Route<dynamic> route) => true);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).i_forgot_password,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .merge(TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor)),
                                  ),
                                ],
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
                                  S.of(context).login,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  _con.login();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: config.App(context).appHorizontalPadding(84),
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/register_verify', (Route<dynamic> route) => true);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).i_dont_have_an_account,
                            style: Theme.of(context).textTheme.subtitle2.merge(
                                TextStyle(
                                    color: Theme.of(context).primaryColor)),
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
      ),
    );
  }
}
