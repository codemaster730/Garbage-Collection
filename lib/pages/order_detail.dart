import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:laji_proj/repository/order_repository.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:amap_maps_flutter/amap_maps_flutter.dart';

import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../repository/user_repository.dart';
// import '../amap_maps_flutter.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
// import 'package:amap_location/amap_location.dart';
import '../const_config.dart';
import '../generated/l10n.dart';
import '../controllers/user_controller.dart';

class OrderDetailWidget extends StatefulWidget {
  dynamic index;
  OrderDetailWidget({
    this.index,
  }) {
    if (index == null) {
      index = {};
    }
  }
  @override
  _OrderDetailWidgetState createState() => _OrderDetailWidgetState();
}

class _OrderDetailWidgetState extends StateMVC<OrderDetailWidget> {
  UserController _con;
  File _colImage;
  bool isPage = false;
  int _current = 0;
  int _current1 = 0;
  String dropdownValue = 'By distance away';
  dynamic apiData = {};
  double _rating = 4.0;

  bool _isVertical = false;
  IconData _selectedIcon;
  Map<String, Marker> _markers = <String, Marker>{};
  AMapController _mapController;

  Future<void> _launched;
  String _phone = '';

  List<File> imageList = [];
  var tempImage;

  OverlayEntry loader;
  List<dynamic> userImages = [], colImages = [];

  _OrderDetailWidgetState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();

    loader = Helper.overlayLoader(context, Colors.grey);
    apiData = widget.index;

    //image setting
    for (var item in apiData['media']) {
      if (item['collection_name'].toString() == "image") {
        userImages.add(item);
      } else {
        colImages.add(item);
      }
    }

    // print("!!!!!!!" + apiData['delivery_address'].toString());
    final Marker marker = Marker(
      position: LatLng(
          double.parse(apiData['delivery_address']['latitude'].toString()),
          double.parse(apiData['delivery_address']['longitude'].toString())),
      infoWindow: InfoWindow(
          title: "Order #" + apiData['id'].toString(),
          snippet: apiData['delivery_address']['address'].toString()),
      // onTap: (markerId) => _onMarkerTapped(markerId),
      // onDragEnd: (markerId, endPosition) =>
      //     _onMarkerDragEnd(markerId, endPosition),
    );
    _markers[marker.id] = marker;
  }

  @override
  Widget build(BuildContext context) {
    final AMapWidget map = AMapWidget(
      onMapCreated: _onMapCreated,
      markers: Set<Marker>.of(_markers.values),
      initialCameraPosition: CameraPosition(
        target: LatLng(
            double.parse(apiData['delivery_address']['latitude'].toString()),
            double.parse(apiData['delivery_address']['longitude'].toString())),
        zoom: 17.0,
        tilt: 30,
      ),
    );

    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              // borderRadius: BorderRadius.only(
              //   bottomRight: Radius.circular(20),
              // ),
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: <Color>[
              //     Theme.of(context).primaryColor,
              //     Theme.of(context).primaryColorDark,
              //   ],
              // ),
              ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 3),
          child: FlatButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 28,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  "Order #" + apiData['id'].toString(),
                  style: TextStyle(
                      fontSize: 22, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            apiData['has_media'] == true
                ? Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: CarouselSlider(
                            options: CarouselOptions(
                                height:
                                    config.App(context).appVerticalPadding(23),
                                autoPlay: false,
                                aspectRatio: 2.0,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                            items: userImages
                                .map<Widget>(
                                  (item) => FlatButton(
                                    onPressed: () {
                                      AwesomeDialog(
                                        context: context,
                                        headerAnimationLoop: false,
                                        dialogType: DialogType.NO_HEADER,
                                        body: Container(
                                            width: config.App(context)
                                                .appHorizontalPadding(90),
                                            height: config.App(context)
                                                .appVerticalPadding(50),
                                            child: PhotoView(
                                              imageProvider: NetworkImage(
                                                item['url'],
                                              ),
                                            )),
                                      )..show();
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      child: Container(
                                        child: Center(
                                            child: Image.network(
                                          item['url'],
                                          fit: BoxFit.fitWidth,
                                          width: config.App(context)
                                              .appHorizontalPadding(100),
                                        )),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: userImages.map<Widget>((url) {
                            int index = userImages.indexOf(url);
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Color.fromRGBO(0, 0, 0, 0.9)
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  )
                : Text(""),
            Expanded(
              flex: 7,
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(25),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (apiData['order_status_id'] < 3)
                          ? SizedBox()
                          : Center(
                              child: RatingBarIndicator(
                                rating:
                                    double.parse(apiData['rate'].toString()),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 50.0,
                                // direction: Axis.vertical,
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "¥" +
                                apiData['payment']['estimated_price']
                                    .toString(),
                            style: TextStyle(fontSize: 24, color: Colors.red),
                          ),
                          Text(
                            "  (" + S.of(context).est_price + ")",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Spacer(),
                          Text(
                            DateFormat('yyyy-MM-dd  kk:mm').format(
                                DateTime.parse(
                                    apiData['created_at'] + "-08:00")),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                      (apiData['order_status_id'] > 2)
                          ? Row(
                              children: [
                                Text(
                                  "¥" + apiData['payment']['price'].toString(),
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.red),
                                ),
                                Text(
                                  "  (" + S.of(context).confirmed_price + ")",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            )
                          : SizedBox(),
                      (apiData['order_status_id'] > 2)
                          ? Row(
                              children: [
                                Text(
                                  "¥" +
                                      apiData['payment']['final_price']
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.red),
                                ),
                                Text(
                                  "  (" + S.of(context).final_price + ")",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                          future: getOrderDetail(apiData['id'].toString()),
                          builder: (context, snapshot) {
                            var package = {};
                            if (snapshot.hasData) {
                              // print(snapshot.data['data']['packages']);

                              for (var pack in snapshot.data['data']
                                  ['packages']) {
                                String id = pack['category_id'].toString();
                                String typeId = pack['type_id'].toString();
                                if (package[id] == null) {
                                  package[id] = {
                                    "name": pack['category']['name'],
                                    "url": pack['category']['media'][0]['url'],
                                    "type": {
                                      typeId: {
                                        "quantity": 1,
                                      },
                                    }
                                  };
                                } else {
                                  if (package[id]['type'][typeId] == null) {
                                    package[id]['type'][typeId] = {
                                      "quantity": 1,
                                    };
                                  } else {
                                    package[id]['type'][typeId]["quantity"] =
                                        package[id]['type'][typeId]
                                                ["quantity"] +
                                            1;
                                  }
                                }
                              }
                              List<Widget> list = [];
                              package.forEach((key, value) {
                                value['type'].forEach((key1, value1) {
                                  list.add(
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      margin: EdgeInsets.all(10),
                                      width: config.App(context)
                                          .appHorizontalPadding(22),
                                      height: config.App(context)
                                          .appHorizontalPadding(22),
                                      child: Column(
                                        children: [
                                          Text(
                                            value1['quantity'].toString() +
                                                currentData
                                                        .value['garbage_unit']
                                                    [key1],
                                          ),
                                          Image.network(
                                            value['url'].toString(),
                                            fit: BoxFit.fill,
                                            height: config.App(context)
                                                .appHorizontalPadding(12),
                                          ),
                                          Text(value['name'].toString()),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              });
                              return Center(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: list,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Location",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: config.App(context).appVerticalPadding(30),
                            width:
                                config.App(context).appHorizontalPadding(100),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                //第二个地图指定初始位置为上海
                                Expanded(
                                  child: map,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: 5,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkResponse(
                                  child: Container(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    width: 40,
                                    height: 40,
                                    color: Colors.blue,
                                  ),
                                  onTap: _zoomIn,
                                ),
                                InkResponse(
                                  child: Container(
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                    color: Colors.blue,
                                    width: 40,
                                    height: 40,
                                  ),
                                  onTap: _zoomOut,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            size: 20,
                            color: Colors.grey,
                          ),
                          Flexible(
                            child: Text(
                              apiData['delivery_address']['address'],
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Contact User",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 20,
                                    color: Colors.black.withOpacity(0.3),
                                  )
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 42.0,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 40.0,
                                  backgroundImage: NetworkImage(
                                      apiData['user']['media'][0]['url']),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      apiData['user']['name'],
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: FlatButton(
                                      onPressed: () {
                                        FlutterPhoneDirectCaller.callNumber(
                                            apiData['user']['phone']);
                                      },
                                      //     =>
                                      //     setState(() {
                                      //   _launched = _makePhoneCall(
                                      //       'tel:${apiData['user']['phone']}');
                                      // }),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            apiData['user']['phone'],
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
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
                      (apiData['order_status_id'] > 2) ? Divider() : SizedBox(),
                      (apiData['order_status_id'] > 2)
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Collector's Images",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          : SizedBox(),
                      (apiData['order_status_id'] > 2)
                          ? Container(
                              child: CarouselSlider(
                                options: CarouselOptions(
                                    height: config.App(context)
                                        .appVerticalPadding(23),
                                    autoPlay: false,
                                    aspectRatio: 2.0,
                                    enlargeCenterPage: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current1 = index;
                                      });
                                    }),
                                items: colImages
                                    .map<Widget>(
                                      (item) => FlatButton(
                                        onPressed: () {
                                          AwesomeDialog(
                                            context: context,
                                            headerAnimationLoop: false,
                                            dialogType: DialogType.NO_HEADER,
                                            body: Container(
                                                width: config.App(context)
                                                    .appHorizontalPadding(90),
                                                height: config.App(context)
                                                    .appVerticalPadding(50),
                                                child: PhotoView(
                                                  imageProvider: NetworkImage(
                                                    item['url'],
                                                  ),
                                                )),
                                          )..show();
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          child: Container(
                                            child: Center(
                                                child: Image.network(
                                              item['url'],
                                              fit: BoxFit.fitWidth,
                                              width: config.App(context)
                                                  .appHorizontalPadding(100),
                                            )),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            )
                          : SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: colImages.map<Widget>((url) {
                          int index = colImages.indexOf(url);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current1 == index
                                  ? Color.fromRGBO(0, 0, 0, 0.9)
                                  : Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          );
                        }).toList(),
                      ),
                      Divider(),
                      apiData['order_status_id'] == 1
                          ? Center(
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
                                      borderRadius: BorderRadius.circular(36.0),
                                    ),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      S.of(context).accept,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      // _con.login();
                                      AwesomeDialog(
                                        context: context,
                                        headerAnimationLoop: false,
                                        dialogType: DialogType.QUESTION,
                                        // body: Text("asdf"),
                                        // title: 'No Header',
                                        desc: S.of(context).do_you_accept_order,
                                        btnOkOnPress: () async {
                                          dynamic res = {};
                                          res = await orderAccept(
                                              apiData['id'].toString());

                                          if (res['success'] == true) {
                                            if (res['data']
                                                    ['order_status_id'] ==
                                                2) {
                                              apiData["order_status_id"] = 2;
                                              // currentOrder.value['data']
                                              //     .add(apiData);
                                              placedOrder.notifyListeners();
                                              currentOrder.notifyListeners();
                                              setState(() {
                                                apiData["order_status_id"] = 2;
                                              });
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      '/home',
                                                      (Route<dynamic> route) =>
                                                          true,
                                                      arguments: 1);
                                            }
                                          }
                                        },
                                        btnOkText: S.of(context).ok,
                                        btnCancelOnPress: () {
                                          Navigator.pop(context);
                                        },
                                        btnCancelText: S.of(context).cancel,
                                        // btnOkIcon: Icons.check_circle,
                                      )..show();
                                    },
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                      apiData['order_status_id'] == 2
                          ? Center(
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
                                      borderRadius: BorderRadius.circular(36.0),
                                    ),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      S.of(context).confirm,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      showBarModalBottomSheet(
                                          isDismissible: true,
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(builder:
                                                (BuildContext context,
                                                    StateSetter
                                                        setInnerState /*You can rename this!*/) {
                                              return SingleChildScrollView(
                                                controller:
                                                    ModalScrollController.of(
                                                        context),
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: Container(
                                                    child: Form(
                                                  key: _con.loginFormKey,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                          "Do you want to confirm this order?"),
                                                      Text(
                                                        "Please select rate and input your price and shot this trash.",
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Container(
                                                        width: 200,
                                                        child: TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                          initialValue: apiData[
                                                                      'payment']
                                                                  [
                                                                  'estimated_price']
                                                              .toString(),
                                                          onSaved: (input) =>
                                                              _con.price =
                                                                  input,
                                                          validator: (input) {
                                                            RegExp _numeric =
                                                                RegExp(
                                                                    r'^-?[0-9\.]+$');
                                                            return !_numeric
                                                                    .hasMatch(
                                                                        input)
                                                                ? "Price should be number."
                                                                : null;
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            prefix: Text(
                                                              "¥ ",
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .hintColor),
                                                            ),
                                                            labelText:
                                                                "Your Price:",
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .always,
                                                            labelStyle: TextStyle(
                                                                fontSize: 20,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    6),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(28.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            TextButton(
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                ),
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            10),
                                                                child: Icon(
                                                                  Icons
                                                                      .add_a_photo_outlined,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                return showCupertinoModalPopup<
                                                                    void>(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return CupertinoActionSheet(
                                                                      title: Text(
                                                                          'Please select the image from the options below.'),
                                                                      actions: <
                                                                          Widget>[
                                                                        CupertinoActionSheetAction(
                                                                          child:
                                                                              Text('Camera'),
                                                                          onPressed: () =>
                                                                              takeImageFromCamera(setInnerState),
                                                                        ),
                                                                        CupertinoActionSheetAction(
                                                                          child:
                                                                              Text('Gallery'),
                                                                          onPressed: () =>
                                                                              takeImageFromGallery(setInnerState),
                                                                        ),
                                                                      ],
                                                                      cancelButton:
                                                                          CupertinoActionSheetAction(
                                                                        isDefaultAction:
                                                                            true,
                                                                        child: Text(
                                                                            'Cancel'),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      ),
                                                                    );
                                                                  },
                                                                );

                                                                // var image = await ImagePicker
                                                                //     .pickImage(
                                                                //         source:
                                                                //             ImageSource.gallery);
                                                                // setInnerState(
                                                                //     () {
                                                                //   if (image !=
                                                                //       null) {
                                                                //     _colImage =
                                                                //         image;
                                                                //   } else {
                                                                //     print(
                                                                //         "No image selected.");
                                                                //   }
                                                                // });

                                                                // takeImage();
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      imageGallery(
                                                          setInnerState),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Center(
                                                        child:
                                                            RatingBar.builder(
                                                          initialRating:
                                                              _rating,
                                                          minRating: 0,
                                                          direction: _isVertical
                                                              ? Axis.vertical
                                                              : Axis.horizontal,
                                                          allowHalfRating:
                                                              false,
                                                          unratedColor: Colors
                                                              .amber
                                                              .withAlpha(50),
                                                          itemCount: 5,
                                                          itemSize: 50.0,
                                                          itemPadding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      4.0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  Icon(
                                                            _selectedIcon ??
                                                                Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          onRatingUpdate:
                                                              (rating) {
                                                            setInnerState(() {
                                                              _rating = rating;
                                                            });
                                                          },
                                                          updateOnDrag: true,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              RaisedButton(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              36.0),
                                                                ),
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(3),
                                                                child: Text(
                                                                  S
                                                                      .of(context)
                                                                      .cancel,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                              SizedBox(
                                                                width: 50,
                                                              ),
                                                              RaisedButton(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              36.0),
                                                                ),
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(3),
                                                                child: Text(
                                                                  S
                                                                      .of(context)
                                                                      .confirm,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                onPressed:
                                                                    () async {
                                                                  if (_con
                                                                      .loginFormKey
                                                                      .currentState
                                                                      .validate()) {
                                                                    _con.loginFormKey
                                                                        .currentState
                                                                        .save();
                                                                    Overlay.of(
                                                                            context)
                                                                        .insert(
                                                                            loader);

                                                                    dynamic
                                                                        res =
                                                                        {};

                                                                    var res1 = await orderConfirm(
                                                                        apiData['id']
                                                                            .toString(),
                                                                        _con.price
                                                                            .toString(),
                                                                        imageList,
                                                                        _rating
                                                                            .toString());
                                                                    apiData[
                                                                        "order_status_id"] = 3;
                                                                    placedOrder
                                                                        .notifyListeners();
                                                                    currentOrder
                                                                        .notifyListeners();
                                                                    setState(
                                                                        () {
                                                                      apiData[
                                                                          "order_status_id"] = 3;
                                                                      apiData['payment']
                                                                              [
                                                                              'price'] =
                                                                          _con.price;
                                                                    });
                                                                    Helper.hideLoader(
                                                                        loader);
                                                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                                                        '/home',
                                                                        (Route<dynamic>
                                                                                route) =>
                                                                            true,
                                                                        arguments:
                                                                            1);
                                                                    //   }
                                                                    // }
                                                                  }
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                              );
                                            });
                                          });
                                    },
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  void takeImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        _colImage = image;
      } else {
        print("No image selected.");
      }
    });
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void takeImageFromGallery(StateSetter setInnerState) async {
    var img = await ImagePicker.pickImage(source: ImageSource.gallery);
    setInnerState(() {
      if (img != null) {
        tempImage = img;
        imageList.add(img);
      } else {
        print("No image selected.");
      }
    });
    Navigator.pop(context);
  }

  void takeImageFromCamera(StateSetter setInnerState) async {
    var img = await ImagePicker.pickImage(source: ImageSource.camera);
    setInnerState(() {
      if (img != null) {
        tempImage = img;
        imageList.add(img);
      } else {
        print("No image selected.");
      }
    });
    Navigator.pop(context);
  }

  Widget imageGallery(StateSetter setInnerState) {
    return Container(
      height: 60,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          ...imageList.map(
            (image) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onLongPress: () {
                  setInnerState(() {
                    imageList.remove(image);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(image.path),
                    width: 90,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
