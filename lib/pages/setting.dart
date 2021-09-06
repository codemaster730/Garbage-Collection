import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../helpers/app_config.dart' as config;
import '../models/language.dart';
import '../repository/settings_repository.dart' as settingRepo;
import '../generated/l10n.dart';
import '../repository/notification_repository.dart';
import '../repository/user_repository.dart';
import '../controllers/user_controller.dart';

class SettingsWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  const SettingsWidget({
    Key key,
    this.parentScaffoldKey,
  }) : super(key: key);
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends StateMVC<SettingsWidget> {
  UserController _con;
  _SettingsWidgetState() : super(UserController()) {
    _con = controller;
  }

  String _message = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: config.App(context).appWidth(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: config.App(context).appHeight(10),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                S.of(context).settings,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            SizedBox(
              height: config.App(context).appHeight(5),
            ),
            ListTile(
              leading: Icon(
                Icons.language_outlined,
                color: config.Colors().mainDarkColor(1),
              ),
              title: Text(
                S.of(context).languages,
                style: TextStyle(
                  color: config.Colors().mainDarkColor(1),
                  fontSize: 18,
                ),
              ),
              trailing: Container(
                width: 120,
                child: DropdownButtonFormField(
                  items: LanguagesList()
                      .getLocalNameList()
                      .map(
                        (e) => DropdownMenuItem(
                          child: Row(
                            children: [
                              Image.asset(
                                LanguagesList().getLocalNameToFlag(e),
                                width: 20,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                e,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                      color: config.Colors().mainDarkColor(1),
                                    ),
                              ),
                            ],
                          ),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    var _lang = LanguagesList()
                        .getLocalNameToLangCode(value)
                        .split("_");
                    if (_lang.length > 1)
                      settingRepo.setting.value.mobileLanguage.value =
                          new Locale(_lang.elementAt(0), _lang.elementAt(1));
                    else
                      settingRepo.setting.value.mobileLanguage.value =
                          new Locale(_lang.elementAt(0));
                    settingRepo.setting.notifyListeners();
                    settingRepo.setDefaultLanguage(
                        LanguagesList().getLocalNameToLangCode(value));
                    // Navigator.pop(context);
                    // print(
                    //     LanguagesList().getLocalNameToLangCode(value).toString());
                    print(settingRepo.setting.value.mobileLanguage.value
                        .toLanguageTag());
                  },
                  hint: Row(
                    children: [
                      Image.asset(
                        LanguagesList().getLocalNameToFlag(LanguagesList()
                            .getLangCodeToLocalName(settingRepo
                                .setting.value.mobileLanguage.value
                                .toLanguageTag()
                                .replaceAll("-", "_"))),
                        width: 20,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        LanguagesList().getLangCodeToLocalName(settingRepo
                            .setting.value.mobileLanguage.value
                            .toLanguageTag()
                            .replaceAll("-", "_")),
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: config.Colors().mainDarkColor(1),
                            ),
                      ),
                    ],
                  ),
                  // decoration: InputDecoration(
                  //   hintText: "English",
                  //   hintStyle: Theme.of(context)
                  //       .textTheme
                  //       .headline5
                  //       .copyWith(color: config.Colors().mainDarkColor(1)),
                  // ),
                ),
              ),
            ),
            SizedBox(
              height: config.App(context).appHeight(3),
              child: Divider(
                thickness: 1,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.privacy_tip_outlined,
                color: config.Colors().mainDarkColor(1),
              ),
              title: Text(
                S.of(context).privacy_policy,
                style: TextStyle(
                  color: config.Colors().mainDarkColor(1),
                  fontSize: 18,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: config.Colors().mainDarkColor(1),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.contact_support_outlined,
                color: config.Colors().mainDarkColor(1),
              ),
              title: Text(
                S.of(context).contact_us,
                style: TextStyle(
                  color: config.Colors().mainDarkColor(1),
                  fontSize: 18,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: config.Colors().mainDarkColor(1),
              ),
              onTap: () {
                showBarModalBottomSheet(
                    isDismissible: true,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (BuildContext context,
                          StateSetter setInnerState /*You can rename this!*/) {
                        return SingleChildScrollView(
                          controller: ModalScrollController.of(context),
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Let's Connect.",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "We'd love to help you start exceeding your goals.",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Container(
                                  // width: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(28.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      minLines:
                                          3, //Normal textInputField will be displayed
                                      maxLines:
                                          7, // when user presses enter it will adapt to it
                                      style: TextStyle(fontSize: 16),
                                      onChanged: (input) => _message = input,
                                      decoration: InputDecoration(
                                        // labelText: "Your message:",
                                        hintText: "Enter your message",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelStyle: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Theme.of(context).primaryColor),
                                        contentPadding: EdgeInsets.all(6),
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(16.0),
                                          ),
                                          // borderSide: BorderSide(
                                          //     color: Theme.of(context).focusColor.withOpacity(0.2)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: SizedBox(
                                    width: config.App(context)
                                        .appHorizontalPadding(40),
                                    height: 40,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red.withAlpha(200),
                                        borderRadius: BorderRadius.circular(36),
                                      ),
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(36.0),
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "Send",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () async {
                                          // _con.login();
                                          dynamic res = {};
                                          res = await contactUsMsg(_message);
                                          if (res['success'] == true) {
                                            _con.scaffoldKey?.currentState
                                                ?.showSnackBar(SnackBar(
                                              content: Text(
                                                  res['message'].toString()),
                                            ));
                                          }
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.question_answer_outlined,
                color: config.Colors().mainDarkColor(1),
              ),
              title: Text(
                S.of(context).faq,
                style: TextStyle(
                  color: config.Colors().mainDarkColor(1),
                  fontSize: 18,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: config.Colors().mainDarkColor(1),
              ),
            ),
            ListTile(
              onTap: () {
                logout();
                Navigator.of(context).pushNamed('/login');
              },
              leading: Icon(
                Icons.logout,
                color: config.Colors().mainDarkColor(1),
              ),
              title: Text(
                S.of(context).log_out,
                style: TextStyle(
                  color: config.Colors().mainDarkColor(1),
                  fontSize: 18,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: config.Colors().mainDarkColor(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
