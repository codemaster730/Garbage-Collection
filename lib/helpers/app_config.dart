import 'package:flutter/cupertino.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

class App {
  BuildContext _context;
  double _height;
  double _width;
  double _heightPadding;
  double _widthPadding;

  App(_context) {
    this._context = _context;
    MediaQueryData _queryData = MediaQuery.of(this._context);
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _heightPadding = _height -
        ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding =
        _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height * v;
  }

  double appWidth(double v) {
    return _width * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding * v;
  }

  double appHorizontalPadding(double v) {
//    int.parse(settingRepo.setting.mainColor.replaceAll("#", "0xFF"));
    return _widthPadding * v;
  }
}

class Colors {
  Color mainColor(double opacity) {
    return Color(0xFFFFFFFF).withOpacity(opacity);
  }

  Color secondColor(double opacity) {
    return Color(0xFF7FB732).withOpacity(opacity);
  }

  Color accentColor(double opacity) {
    return Color(0xFF2680EB).withOpacity(opacity);
  }

  Color mainDarkColor(double opacity) {
    return Color(0xFF111111).withOpacity(opacity);
  }

  Color secondDarkColor(double opacity) {
    return Color(0xFFEEEEEE).withOpacity(opacity);
  }

  Color accentDarkColor(double opacity) {
    return Color(0xFFAAAAAA).withOpacity(opacity);
  }
}

class ConstConfig {
  static const AMapApiKey amapApiKeys = AMapApiKey(
      androidKey: 'e3c2a195f85d7d278e1aa7658cbf7864',
      iosKey: '03e162d49d6456ad704364dc2bb5ac75');

  static const String amapKey = "aa1b2c63b9bfdd9f78e75952825e50f4";
}
