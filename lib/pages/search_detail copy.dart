import 'package:flutter/material.dart';
import '../helpers/app_config.dart' as config;
import '../repository/user_repository.dart';
import '../helpers/widget_manage.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _con.scaffoldKey,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.only(
      //         bottomRight: Radius.circular(20),
      //       ),
      //       gradient: LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //         colors: <Color>[
      //           Theme.of(context).primaryColor,
      //           Theme.of(context).primaryColorDark,
      //         ],
      //       ),
      //     ),
      //   ),
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   title: Padding(
      //     padding: const EdgeInsets.only(left: 5.0, top: 3),
      //     child: FlatButton(
      //       padding: const EdgeInsets.all(0),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       child: Row(
      //         children: [
      //           Icon(
      //             Icons.arrow_back_ios,
      //             size: 28,
      //             color: Colors.white,
      //           ),
      //           Text(
      //             "Search",
      //             style: TextStyle(fontSize: 22, color: Colors.white),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),

      body: Stack(
        children: [
          // Text("Search Detail"),
          Positioned(
            top: config.App(context).appVerticalPadding(22),
            child: Container(
              height: config.App(context).appVerticalPadding(70),
              // padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: SingleChildScrollView(
                // scrollDirection: Axis.vertical,
                child: Column(
                  children: WidgetManage().getOrderList("1", context, true),
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      enabled: false,
                      initialValue: currentUser.value.address,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.left,
                      // onSaved: (input) => _con.user.email = input,
                      validator: (input) => !input.contains('@')
                          ? "Should be a valid email"
                          : null,
                      decoration: InputDecoration(
                        hintText: "Addreses",
                        labelStyle: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                        contentPadding: EdgeInsets.all(12),
                        prefixIcon: Icon(
                          Icons.pin_drop,
                          size: 26,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(16.0),
                          ),
                          // borderSide: BorderSide(
                          //     color: Theme.of(context).focusColor.withOpacity(0.2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(16.0),
                            ),
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.5))),
                        // enabledBorder: OutlineInputBorder(
                        //     borderRadius: const BorderRadius.all(
                        //       const Radius.circular(16.0),
                        //     ),
                        //     borderSide: BorderSide(
                        //         color:
                        //             Theme.of(context).focusColor.withOpacity(0.2))),
                      ),
                    ),
                  ),
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
                ],
              ),
            ),
          ),
          buildFloatingSearchBar(),
        ],
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
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
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
