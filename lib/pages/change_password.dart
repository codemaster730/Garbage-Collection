import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/user_controller.dart';
import '../repository/user_repository.dart';
import '../models/route_argument.dart';
import '../generated/l10n.dart';
import '../helpers/app_config.dart' as config;

class ChangePasswordScreen extends StatefulWidget {
  final RouteArgument routeArgument;

  const ChangePasswordScreen({Key key, this.routeArgument}) : super(key: key);
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends StateMVC<ChangePasswordScreen> {
  UserController _con;
  TextEditingController passController = TextEditingController();
  _ChangePasswordScreenState() : super(UserController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _con.loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: config.App(context).appHeight(15),
                  ),
                  Text(
                    "更改密码",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(
                    height: config.App(context).appHeight(5),
                  ),
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: config.App(context).appWidth(10),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: config.Colors().mainColor(1),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          width: config.App(context).appWidth(90),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: config.App(context).appHeight(3),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: TextFormField(
                                  controller: passController,
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  validator: (input) => input.isEmpty == true
                                      ? S
                                          .of(context)
                                          .should_be_more_than_3_letters
                                      : null,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).password,
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            color: config.Colors()
                                                .mainDarkColor(1)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: config.App(context).appHeight(7),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -25,
                        right: config.App(context).appWidth(25),
                        left: config.App(context).appWidth(25),
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                            vertical: config.App(context).appWidth(3),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              S.of(context).submit,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            _con.changePassword(
                              passController.text,
                              registerPhone.value,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: config.App(context).appHeight(10),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
