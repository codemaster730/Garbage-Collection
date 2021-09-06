import 'package:flutter/material.dart';
import '../helpers/app_config.dart' as config;
import '../repository/user_repository.dart';
import '../helpers/widget_manage.dart';

class SearchWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  const SearchWidget({
    Key key,
    this.parentScaffoldKey,
  }) : super(key: key);
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool isPage = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _con.scaffoldKey,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   title: Padding(
      //     padding: const EdgeInsets.only(left: 5.0, top: 3),
      //     child: Text(
      //       "Search",
      //       style: Theme.of(context).textTheme.headline1,
      //     ),
      //   ),
      // ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
                width: config.App(context).appHorizontalPadding(100),
                height: config.App(context).appVerticalPadding(45),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorDark,
                    ],
                  ),
                ),
                padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text(
                          currentUser.value.address,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/search', (Route<dynamic> route) => true);
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Search City/Area",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Icon(
                                Icons.now_widgets_outlined,
                                size: 36,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              isPage = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: !isPage
                                  ? Border(
                                      bottom: BorderSide(
                                          width: 3.0, color: Colors.white),
                                    )
                                  : null,
                            ),
                            child: Text(
                              "Recommend",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              isPage = true;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: isPage
                                  ? Border(
                                      bottom: BorderSide(
                                          width: 3.0, color: Colors.white),
                                    )
                                  : null,
                            ),
                            child: Text(
                              "Recent",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          Positioned(
            top: config.App(context).appVerticalPadding(45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      Text(
                        !isPage
                            ? "Displaying nearby's orders"
                            : "Displaying your recent orders here",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: config.App(context).appHorizontalPadding(100),
                  height: config.App(context).appVerticalPadding(45),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: WidgetManage().getOrderList(
                          "/getRecommendedOrderList", context, false),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   top: 0,
          //   child: Text("data"),
          // ),
        ],
      ),
    );
  }
}
