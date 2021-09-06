import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../elements/CircularLoadingWidget.dart';
import '../generated/l10n.dart';
import '../helpers/app_config.dart' as config;

class Helper {
  BuildContext context;
  DateTime currentBackPressTime;

  Helper.of(BuildContext _context) {
    this.context = _context;
  }

  static OverlayEntry overlayLoader(context, pColor) {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: Material(
          color: Colors.grey.withOpacity(0.25),
          child: CircularLoadingWidget(height: 200, circleColor: pColor),
        ),
      );
    });
    return loader;
  }

  Future<String> getAddressName(String latLng) async {
    String address = "";
    final String url =
        '${GlobalConfiguration().getValue('amap_restapi_url')}?output=json&location=$latLng&key=${config.ConstConfig.amapKey}';
    final client = new http.Client();

    final response = await client.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );

    if (response.statusCode == 200) {
      address = json.decode(response.body)["regeocode"]["formatted_address"];
    }

    return address;
  }

  static hideLoader(OverlayEntry loader) {
    Timer(Duration(milliseconds: 500), () {
      try {
        loader?.remove();
      } catch (e) {}
    });
  }

  static removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  // for mapping data retrieved form json array
  static getData(Map<String, dynamic> data) {
    return data['data'] ?? [];
  }

  static int getIntData(Map<String, dynamic> data) {
    return (data['data'] as int) ?? 0;
  }

  static bool getBoolData(Map<String, dynamic> data) {
    return (data['data'] as bool) ?? false;
  }

  static getObjectData(Map<String, dynamic> data) {
    return data['data'] ?? new Map<String, dynamic>();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: S.of(context).tapAgainToLeave);
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }

  static getDayFromTimeStamp(String date) {
    var parsedDate = DateTime.parse(date);
    return parsedDate.day.toString();
  }

  static getDateStringFromTimeStamp(String date) {
    var parsedDate = DateTime.parse(date);
    return DateFormat("d MMM, yyyy").format(parsedDate);
  }

  String trans(String text) {
    switch (text) {
      case "App\\Notifications\\StatusChangedOrder":
        return S.of(context).order_status_changed;
      case "App\\Notifications\\NewMessage":
        return S.of(context).new_order_from_client;
      case "App\\Notifications\\NewAllMessage":
        return "All Message";
      case "App\\Notifications\\NewAllUsersMessage":
        return "Bulk Users Message";
      case "km":
        return S.of(context).km;
      case "mi":
        return S.of(context).mi;
      default:
        return text;
    }
  }
}
