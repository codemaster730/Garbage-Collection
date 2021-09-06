import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laji_proj/repository/order_repository.dart';

import 'package:geolocator/geolocator.dart';
import '../helpers/app_config.dart' as config;
import '../repository/user_repository.dart';

import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

import 'package:amap_location/amap_location.dart' as amapLoc;

import '../generated/l10n.dart';
import '../const_config.dart';
import '../helpers/api.dart';
import '../helpers/widget_manage.dart';

class MapDetailWidget extends StatefulWidget {
  @override
  _MapDetailWidgetState createState() => _MapDetailWidgetState();
}

class _MapDetailWidgetState extends State<MapDetailWidget> {
  Widget _poiInfo = Text("");
  Map<String, Marker> _markers = <String, Marker>{};
  AMapController _mapController;
  BitmapDescriptor myIcon;

  void setMarker() {
    if (null == myIcon) {
      myIcon = BitmapDescriptor.fromIconPath('assets/img/start.png');
    }
    dynamic listData;

    listData = Api().getApiData('/getRecommendedOrderList');

    Marker marker = new Marker(
        position: LatLng((currentUser.value.lat), (currentUser.value.long)),
        icon: myIcon,
        infoWindow:
            InfoWindow(title: '我的位置', snippet: currentUser.value.address),
        onTap: (markerId) {
          setState(() {
            _poiInfo = Text("collector");
          });
        });
    _markers["my_location"] = marker;
    var _context = context;
    for (var item in placedOrder.value['data']) {
      Marker marker = new Marker(
        clickable: true,
        position: LatLng(
            double.parse(item['delivery_address']['latitude'].toString()),
            double.parse(item['delivery_address']['longitude'].toString())),
        infoWindow: InfoWindow(
            title: "#" + item['id'].toString(),
            snippet: item['delivery_address']['address']),
        onTap: (markerId) {
          print("click");
          Navigator.of(_context).pushNamedAndRemoveUntil(
              '/orderDetail', (Route<dynamic> route) => true,
              arguments: item);
        },
        // onDragEnd: (markerId, endPosition) =>
        //     _onMarkerDragEnd(markerId, endPosition),
      );
      _markers[marker.id] = marker;
    }
  }

  @override
  void initState() {
    super.initState();
    // try {
    //   if (Platform.isAndroid) {
    //     amapLoc.AMapLocationClient.setApiKey(
    //         config.ConstConfig.amapApiKeys.androidKey);
    //   } else if (Platform.isIOS) {
    //     amapLoc.AMapLocationClient.setApiKey(
    //         config.ConstConfig.amapApiKeys.iosKey);
    //   }
    // } on PlatformException {
    //   print('Failed to get platform version');
    // }
    setMarker();
    // print("!!!!!!!!!" + currentUser.value.location.toString());
  }

  @override
  Widget build(BuildContext context) {
    // setMarker();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          S.of(context).address,
          style: Theme.of(context).textTheme.headline2,
        ),
        centerTitle: true,
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: AMapWidget(
                apiKey: ConstConfig.amapApiKeys,
                onMapCreated: _onMapCreated,
                markers: Set<Marker>.of(_markers.values),
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        (currentUser.value.lat), (currentUser.value.long)),
                    zoom: 13.0,
                    tilt: 30),
                // touchPoiEnabled: true,
                // onCameraMoveEnd: _onCameraMoveEnd,
                onLocationChanged: _onLocationChanged,
                // onPoiTouched: _onPoiTouched,
              ),
            ),
            // Positioned(
            //   top: 40,
            //   child: Container(
            //     width: config.App(context).appHorizontalPadding(90),
            //     height: 150,
            //     color: Colors.white.withAlpha(100),
            //     child: _poiInfo,
            //   ),
            // ),
            Positioned(
              right: 5,
              bottom: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      child: Icon(
                        Icons.my_location_outlined,
                        color: Colors.white,
                      ),
                      width: 40,
                      height: 40,
                      color: Colors.blue,
                    ),
                    onPressed: () => _determinePosition().then((value) {
                      _mapController.moveCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: LatLng(value.latitude, value.longitude),
                              zoom: 13.0,
                              tilt: 30),
                        ),
                        animated: true,
                      );
                    }),
                  ),
                  FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      width: 40,
                      height: 40,
                      color: Colors.blue,
                    ),
                    onPressed: _zoomIn,
                  ),
                  FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                      color: Colors.blue,
                      width: 40,
                      height: 40,
                    ),
                    onPressed: _zoomOut,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget showPoiInfo(AMapPoi poi) {
  //   return Container(
  //     alignment: Alignment.center,
  //     color: Color(0x8200CCFF),
  //     child: Text(
  //       '您点击了 ${poi.name}, ${poi.latLng},',
  //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
  //     ),
  //   );
  // }

  //移动地图结束
  // void _onCameraMoveEnd(CameraPosition cameraPosition) {
  //   setState(() {
  //     _poiInfo = Container(
  //       alignment: Alignment.center,
  //       color: Color(0x8200CCFF),
  //       child: Text(
  //         '点: ${cameraPosition.zoom}, ${cameraPosition.target.latitude}, ${cameraPosition.target.longitude}, ${cameraPosition.tilt},',
  //         style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
  //       ),
  //     );
  //   });
  // }

  void _onLocationChanged(AMapLocation location) {
    // print('!!!!!!!! ${location.toJson()}');
  }

  void _onPoiTouched(AMapPoi poi) {
    setState(() {
      // _poiInfo = showPoiInfo(poi);
    });
  }

  void _onMapCreated(AMapController controller) {
    _mapController = controller;
  }

  //级别加1
  void _zoomIn() {
    _mapController.moveCamera(
      CameraUpdate.zoomIn(),
      animated: true,
    );
  }

  //级别减1
  void _zoomOut() {
    _mapController.moveCamera(
      CameraUpdate.zoomOut(),
      animated: true,
    );
  }

  Future<amapLoc.AMapLocation> _determinePosition() async {
    // bool serviceEnabled;
    // LocationPermission permission;
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled.');
    // }

    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     return Future.error('Location permissions are denied');
    //   }
    // }

    // if (permission == LocationPermission.deniedForever) {
    //   return Future.error(
    //       'Location permissions are permanently denied, we cannot request permissions.');
    // }
    // return await Geolocator.getCurrentPosition();

    await amapLoc.AMapLocationClient.startup(new amapLoc.AMapLocationOption(
        desiredAccuracy: amapLoc.CLLocationAccuracy.kCLLocationAccuracyBest));
    return await amapLoc.AMapLocationClient.getLocation(true);
  }
}
