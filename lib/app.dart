import 'package:flutter/material.dart';
import 'route_generator.dart';
import 'generated/l10n.dart';
import 'models/setting.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'repository/settings_repository.dart' as settingRepo;
import './helpers/app_config.dart' as config;

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: settingRepo.setting,
      builder: (context, Setting _setting, _) {
        return MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: config.Colors().mainColor(1),
            primaryColor: config.Colors().secondColor(1),
            accentColor: config.Colors().accentColor(1),
            cardColor: config.Colors().secondDarkColor(1),
            dividerColor: config.Colors().mainDarkColor(0.1),
            hintColor: config.Colors().accentDarkColor(1),
            textTheme: TextTheme(
              headline6: TextStyle(
                fontSize: 20,
                color: config.Colors().mainColor(1),
                fontWeight: FontWeight.normal,
                height: 1.4,
              ),
              headline5: TextStyle(
                fontSize: 18,
                color: config.Colors().accentDarkColor(1),
                fontWeight: FontWeight.normal,
                height: 1.3,
              ),
              headline4: TextStyle(
                fontSize: 17,
                color: config.Colors().secondColor(1),
                fontWeight: FontWeight.normal,
                height: 1.3,
              ),
              headline3: TextStyle(
                fontSize: 17,
                color: config.Colors().accentDarkColor(1),
                fontWeight: FontWeight.normal,
                height: 1.3,
              ),
              headline2: TextStyle(
                fontSize: 16,
                color: config.Colors().mainDarkColor(1),
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
              headline1: TextStyle(
                fontSize: 28,
                color: config.Colors().secondColor(1),
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
              bodyText2: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: config.Colors().secondColor(1),
                  height: 1.2),
              bodyText1: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: config.Colors().secondColor(1),
                  height: 1.3),
            ),
          ),
          initialRoute: '/Splash',
          onGenerateRoute: RouteGenerator.generateRoute,
          locale: _setting.mobileLanguage.value,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
