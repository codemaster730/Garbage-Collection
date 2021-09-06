import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';

import 'package:amap_location/amap_location.dart' as amapLoc;
import 'helpers/app_config.dart' as config;
import './app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("configurations");
  try {
    if (Platform.isAndroid) {
      amapLoc.AMapLocationClient.setApiKey(
          config.ConstConfig.amapApiKeys.androidKey);
    } else if (Platform.isIOS) {
      amapLoc.AMapLocationClient.setApiKey(
          config.ConstConfig.amapApiKeys.iosKey);
    }
  } on PlatformException {
    print('Failed to get platform version');
  }
  runApp(App());
}
