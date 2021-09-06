import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:geolocator/geolocator.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

import 'package:amap_location/amap_location.dart' as amapLoc;
import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../repository/user_repository.dart';
import '../controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../generated/l10n.dart';
import '../models/route_argument.dart';

class ProfileWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  const ProfileWidget({
    Key key,
    this.parentScaffoldKey,
  }) : super(key: key);
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends StateMVC<ProfileWidget> {
  // bool isEdit = false;
  File img;
  Map<String, Marker> _markers = <String, Marker>{};
  Map<String, Marker> _markers1 = <String, Marker>{};
  AMapController _mapController;
  AMapController _mapController1;
  UserController _con;
  OverlayEntry loader;
  TextEditingController _textAddressController;

  double latitude;
  double longitude;
  String _address;

  _ProfileWidgetState() : super(UserController()) {
    _con = controller;
  }

  LatLng _userPos = LatLng(
    (currentUser.value.lat),
    (currentUser.value.long),
  );
  LatLng _endPos;
  @override
  void initState() {
    super.initState();
    loader = Helper.overlayLoader(context, Colors.grey);
    latitude = (currentUser.value.lat);
    longitude = (currentUser.value.long);

    _con.user.address = currentUser.value.address;
    _con.user.lat = currentUser.value.lat;
    _con.user.long = currentUser.value.long;
    _textAddressController = TextEditingController();
    _textAddressController.text = _con.user.address;

    Marker marker = Marker(
      // draggable: true,
      position: _userPos,
      // infoWindow: InfoWindow(
      //     title: S.of(context).address, snippet: currentUser.value.address),
      // onTap: (markerId) => _onMarkerTapped(markerId),
      // onDragEnd: (markerId, endPosition) =>
      //     _onMarkerDragEnd(markerId, endPosition),
    );
    _markers["col"] = marker;

    Marker marker1 = Marker(
      draggable: true,
      position: _userPos,
      // infoWindow: InfoWindow(
      //     title: S.of(context).address, snippet: currentUser.value.address),
      // onTap: (markerId) => _onMarkerTapped(markerId),
      // onDragEnd: (markerId, endPosition) =>
      //     _onMarkerDragEnd(markerId, endPosition),
    );
    _markers1["col"] = marker1;
  }

  void getAvatar() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        img = image;

        print(img.toString());
      } else {
        print("No image selected.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.only(left: 5.0, top: 3),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              S.of(context).profile,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: config.App(context).appWidth(10),
        ),
        child: Form(
          key: _con.loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: config.App(context).appHeight(10),
                child: Container(
                  width: config.App(context).appWidth(100),
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      _con.isEdit == false
                          ? S.of(context).edit_profile
                          : S.of(context).cancel,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _con.isEdit = !_con.isEdit;
                      });
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: DottedBorder(
                  borderType: BorderType.Circle,
                  padding: EdgeInsets.all(10.0),
                  color: config.Colors().secondColor(0.5),
                  dashPattern: [8, 8],
                  strokeWidth: 2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(300)),
                        child: img == null
                            ? Image(
                                image:
                                    NetworkImage(currentUser.value.image.url),
                                width: config.App(context).appWidth(30),
                                height: config.App(context).appWidth(30),
                                fit: BoxFit.cover,
                              )
                            : Image(
                                width: config.App(context).appWidth(30),
                                height: config.App(context).appWidth(30),
                                fit: BoxFit.cover,
                                image: FileImage(img),
                              ),
                      ),
                      _con.isEdit == true
                          ? InkWell(
                              onTap: getAvatar,
                              child: Icon(
                                Icons.upload_file,
                                size: 80,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: config.App(context).appHeight(3),
              ),
              _con.isEdit == false
                  ? Text(
                      currentUser.value.name,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            color: config.Colors().mainDarkColor(1),
                          ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: config.App(context).appWidth(20)),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20),
                        onSaved: (input) => _con.user.name = input,
                        validator: (input) => input.length < 2
                            ? S.of(context).name_should_be_2
                            : null,
                        initialValue: currentUser.value.name,
                        decoration: InputDecoration(
                          labelText: S.of(context).name,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor),
                          contentPadding: EdgeInsets.all(6),
                        ),
                      ),
                    ),
              SizedBox(
                height: config.App(context).appHeight(1),
              ),
              Text(
                "+" + currentUser.value.phone,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      fontSize: 17,
                    ),
              ),
              SizedBox(
                height: config.App(context).appHeight(1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Color(0xFFE8C742),
                  ),
                  Icon(
                    Icons.star,
                    color: Color(0xFFE8C742),
                  ),
                  Icon(
                    Icons.star,
                    color: Color(0xFFE8C742),
                  ),
                  Icon(
                    Icons.star,
                    color: Color(0xFFE8C742),
                  ),
                  Icon(
                    Icons.star,
                    color: Color(0xFFE8C742),
                  ),
                  Text(
                    "(" + currentUser.value.score + ")",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          fontSize: 17,
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: config.App(context).appHeight(3),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: config.App(context).appHeight(3),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 1,
                    ),
                    child: Text(S.of(context).gender,
                        style: Theme.of(context).textTheme.headline5),
                  ),
                  _con.isEdit == false
                      ? Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                currentUser.value.gender == 0
                                    ? S.of(context).male
                                    : S.of(context).female,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                      color: config.Colors().mainDarkColor(1),
                                    ),
                              ),
                              Divider(
                                color: Theme.of(context).hintColor,
                                thickness: 1,
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 1,
                          ),
                          child: DropdownButtonFormField(
                            items: [S.of(context).male, S.of(context).female]
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text(
                                      e,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                            color: config.Colors()
                                                .mainDarkColor(1),
                                          ),
                                    ),
                                    value: e,
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == S.of(context).male)
                                _con.user.gender = 0;
                              else
                                _con.user.gender = 1;
                            },
                            value: currentUser.value.gender == 0
                                ? S.of(context).male
                                : S.of(context).female,
                            validator: (input) =>
                                input.isEmpty == true ? "* Required!" : null,
                            decoration: InputDecoration(
                              // hintText: "",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                      color: config.Colors().mainDarkColor(1)),
                            ),
                          ),
                        ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Text(S.of(context).address,
                            style: Theme.of(context).textTheme.headline5),
                        Spacer(),
                        _con.isEdit == false
                            ? Text("")
                            : ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  color: Theme.of(context).primaryColor,
                                  child: FlatButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      // _con.login();

                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(
                                                builder: (context, setState) {
                                              return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  elevation: 16,
                                                  child: Container(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              "Pick your address position in this map."),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Stack(
                                                          children: [
                                                            Container(
                                                              width: 400,
                                                              height: 550,
                                                              child: AMapWidget(
                                                                onMapCreated:
                                                                    _onMapCreated1,
                                                                markers: Set<
                                                                        Marker>.of(
                                                                    _markers1
                                                                        .values),
                                                                initialCameraPosition:
                                                                    CameraPosition(
                                                                  target:
                                                                      LatLng(
                                                                    (latitude),
                                                                    (longitude),
                                                                  ),
                                                                  zoom: 13.0,
                                                                ),
                                                                onTap:
                                                                    (latLng) {
                                                                  Overlay.of(
                                                                          context)
                                                                      .insert(
                                                                          loader);
                                                                  Helper.of(
                                                                          context)
                                                                      .getAddressName(
                                                                          "${latLng.longitude},${latLng.latitude}")
                                                                      .then(
                                                                          (address) {
                                                                    setState(
                                                                        () {
                                                                      _address =
                                                                          address;
                                                                      latitude =
                                                                          latLng
                                                                              .latitude;
                                                                      longitude =
                                                                          latLng
                                                                              .longitude;

                                                                      var marker1 =
                                                                          new Marker(
                                                                        position: LatLng(
                                                                            latLng.latitude,
                                                                            latLng.longitude),
                                                                        infoWindow: InfoWindow(
                                                                            title:
                                                                                S.of(context).address,
                                                                            snippet: address),
                                                                      );
                                                                      _markers1
                                                                          .clear();
                                                                      _markers1[
                                                                              'col'] =
                                                                          marker1;
                                                                      Helper.hideLoader(
                                                                          loader);
                                                                    });
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            Positioned(
                                                              top: 10,
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                child: _address !=
                                                                        null
                                                                    ? Container(
                                                                        padding:
                                                                            EdgeInsets.all(8),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          '$_address',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : SizedBox(),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              right: 5,
                                                              bottom: 5,
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  FlatButton(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(0),
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .my_location_outlined,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      width: 40,
                                                                      height:
                                                                          40,
                                                                      color: Colors
                                                                          .blue,
                                                                    ),
                                                                    onPressed: () =>
                                                                        _determinePosition()
                                                                            .then((value) {
                                                                      _mapController1
                                                                          .moveCamera(
                                                                        CameraUpdate
                                                                            .newCameraPosition(
                                                                          CameraPosition(
                                                                              target: LatLng(value.latitude, value.longitude),
                                                                              zoom: 13.0,
                                                                              tilt: 30),
                                                                        ),
                                                                        animated:
                                                                            true,
                                                                      );
                                                                    }),
                                                                  ),
                                                                  InkResponse(
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      width: 40,
                                                                      height:
                                                                          40,
                                                                      color: Colors
                                                                          .blue,
                                                                    ),
                                                                    onTap:
                                                                        _zoomIn1,
                                                                  ),
                                                                  InkResponse(
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      color: Colors
                                                                          .blue,
                                                                      width: 40,
                                                                      height:
                                                                          40,
                                                                    ),
                                                                    onTap:
                                                                        _zoomOut1,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 25,
                                                        ),
                                                        Center(
                                                          child: SizedBox(
                                                            width: config.App(
                                                                    context)
                                                                .appHorizontalPadding(
                                                                    40),
                                                            height: 40,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .red
                                                                    .withAlpha(
                                                                        200),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            36),
                                                              ),
                                                              child:
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
                                                                        .all(
                                                                            10),
                                                                child: Text(
                                                                  "Confirm",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                onPressed: () {
                                                                  this.setState(
                                                                      () {
                                                                    _textAddressController
                                                                            .text =
                                                                        _address;
                                                                    _con.user
                                                                            .lat =
                                                                        latitude;
                                                                    _con.user
                                                                            .long =
                                                                        longitude;
                                                                  });

                                                                  // _con.login();
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ));
                                            });
                                          });
                                    },
                                    child: Icon(
                                      Icons.pin_drop,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  !_con.isEdit
                      ? Text(
                          currentUser.value.address,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                color: config.Colors().mainDarkColor(1),
                              ),
                        )
                      : TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _textAddressController,
                          style: TextStyle(fontSize: 16),
                          onSaved: (input) => _con.user.address = input,
                          // initialValue: _address,
                          decoration: InputDecoration(
                            // labelText: S.of(context).name,
                            // floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                            contentPadding: EdgeInsets.all(1),
                          ),
                        ),
                  Stack(
                    children: [
                      Container(
                        width: 400,
                        height: 300,
                        child: AMapWidget(
                          onMapCreated: _onMapCreated,
                          markers: Set<Marker>.of(_markers.values),
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              (currentUser.value.lat),
                              (currentUser.value.long),
                            ),
                            zoom: 17.0,
                            tilt: 30,
                          ),
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
                  SizedBox(
                    height: config.App(context).appHeight(8),
                  ),
                  _con.isEdit == true
                      ? FlatButton(
                          padding: EdgeInsets.symmetric(
                            vertical: config.App(context).appWidth(3),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Send",
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
                            setState(() {
                              _con.isEdit = false;
                            });
                            setState(() {
                              _con.user.id = currentUser.value.id;
                              _con.user.apiToken = currentUser.value.apiToken;
                            });

                            _con.updateProfile(img);
                          },
                        )
                      : SizedBox(),
                  SizedBox(
                    height: config.App(context).appHeight(5),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context)
                      //     .pushNamed('/forgot_password_verify');
                      registerPhone.value = currentUser.value.phone;
                      Navigator.of(context).pushNamed('/forgot_password',
                          arguments: RouteArgument(param: '/home'));
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        S.of(context).change_password,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: config.Colors().mainDarkColor(0.5),
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: config.App(context).appHeight(2),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     logout();
                  //     Navigator.of(context).pushNamed('/login');
                  //   },
                  //   child: Align(
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       "登出",
                  //       style: Theme.of(context).textTheme.headline5.copyWith(
                  //             color: config.Colors().mainDarkColor(0.5),
                  //           ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: config.App(context).appHeight(10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onMapCreated(AMapController controller) {
    _mapController = controller;
  }

  void _onMapCreated1(AMapController controller) {
    _mapController1 = controller;
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

  //级别加1
  void _zoomIn1() {
    _mapController1.moveCamera(
      CameraUpdate.zoomIn(),
      animated: true,
    );
  }

  //级别减1
  void _zoomOut1() {
    _mapController1.moveCamera(
      CameraUpdate.zoomOut(),
      animated: true,
    );
  }

  void _onMarkerDragEnd(String markerId, LatLng position) {
    print("!!!!!!!!!!!" + position.toString());
    // _endPos = position;
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
