import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../helpers/app_config.dart' as config;
import '../repository/user_repository.dart';
import '../repository/order_repository.dart';

import '../generated/l10n.dart';
import '../helpers/widget_manage.dart';
import '../helpers/helper.dart';

class SearchDetailWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  const SearchDetailWidget({
    Key key,
    this.parentScaffoldKey,
  }) : super(key: key);
  @override
  _SearchDetailWidgetState createState() => _SearchDetailWidgetState();
}

class _SearchDetailWidgetState extends State<SearchDetailWidget> {
  bool isPage = false;
  String dropdownValue = 'By distance away';
  dynamic _placedOrders = {};

  @override
  void initState() {
    super.initState();
    getPlacedOrder("");
    // _placedOrders = getPlacedOrder();
    // print("AAAAAAAAAA:" + _placedOrders);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: placedOrder,
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Container(
                padding: const EdgeInsets.only(left: 5.0, top: 3),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).order_search,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
            ),
            body: Container(
              child: Column(
                children: [
                  Container(
                    width: config.App(context).appHorizontalPadding(100),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: ListTile(
                        title: DropdownButtonFormField(
                          items: [
                            S.of(context).near_to_location,
                            S.of(context).sort_by_price
                          ]
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Row(
                                    children: [
                                      e == S.of(context).near_to_location
                                          ? Icon(Icons.location_searching)
                                          : Icon(Icons.money),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        e,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            .copyWith(
                                              color: config.Colors()
                                                  .mainDarkColor(1),
                                            ),
                                      ),
                                    ],
                                  ),
                                  value: e,
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            getPlacedOrder(value.toString() ==
                                    S.of(context).near_to_location
                                ? "distance"
                                : "price");
                            print(value);
                          },
                          hint: Row(
                            children: [
                              // Icon(Icons.location_searching),
                              // SizedBox(
                              //   width: 5,
                              // ),
                              Text(
                                S.of(context).near_to_location +
                                    "/" +
                                    S.of(context).sort_by_price,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        // Text(
                        //   S.of(context).near_to_your_current_location,
                        //   style: TextStyle(fontSize: 18, color: Colors.black),
                        // ),
                        trailing: ClipRRect(
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
                                print("ok");
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/mapDetail',
                                    (Route<dynamic> route) => true);
                              },
                              child: Icon(
                                Icons.pin_drop,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: config.App(context).appVerticalPadding(75),
                    width: config.App(context).appHorizontalPadding(100),
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: SingleChildScrollView(
                      child: Column(
                        children: WidgetManage()
                            .getPlacedOrderList("1", context, value),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: S.of(context).search + "...",
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      automaticallyImplyBackButton: true,
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {
              print("circluer");
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sort by",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                size: 28,
                                color: Colors.black,
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.black),
                              underline: Container(
                                height: 0,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                'By distance away',
                                'Price',
                                'State'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      Container(height: 80, child: VerticalDivider()),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Filter by",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            Row(
                              children: [
                                Text(
                                  "None",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 28,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Column(
                //   mainAxisSize: MainAxisSize.min,
                //   children: Colors.accents.map((color) {
                //     return Container(height: 112, color: color);
                //   }).toList(),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
