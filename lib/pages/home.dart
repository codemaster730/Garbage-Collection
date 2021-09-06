import 'package:flutter/material.dart';
import '../models/route_argument.dart';
import '../helpers/helper.dart';
import './search.dart';
import './search_detail.dart';
import './history.dart';
import './notification.dart';
import './notifications.dart';
import './setting.dart';
import './profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

// ignore: must_be_immutable
class HomeWidget extends StatefulWidget {
  dynamic currentTab;
  RouteArgument routeArgument;
  Widget currentPage = SearchDetailWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  HomeWidget({
    Key key,
    this.currentTab,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 0;
    }
  }

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  // List<TabItem> tabItems = List.of([
  //   new TabItem(Icons.home, "Home", Colors.blue,
  //       labelStyle: TextStyle(fontWeight: FontWeight.normal)),
  //   new TabItem(Icons.search, "Search", Colors.orange,
  //       labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
  //   new TabItem(Icons.layers, "Reports", Colors.red),
  //   new TabItem(Icons.notifications, "Notifications", Colors.cyan),
  // ]);

  @override
  void initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = SearchDetailWidget(
            parentScaffoldKey: widget.scaffoldKey,
          );
          break;
        case 1:
          widget.currentPage = HistoryWidget(
            parentScaffoldKey: widget.scaffoldKey,
          );
          break;
        case 2:
          widget.currentPage = NotificationsWidget(
            parentScaffoldKey: widget.scaffoldKey,
          );
          break;
        case 3:
          widget.currentPage = ProfileWidget(
            parentScaffoldKey: widget.scaffoldKey,
          );
          break;
        case 4:
          widget.currentPage = SettingsWidget(
            parentScaffoldKey: widget.scaffoldKey,
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        body: widget.currentPage,
        bottomNavigationBar: CurvedNavigationBar(
          index: widget.currentTab,
          height: 55.0,
          color: Colors.grey.shade200,
          // color: Theme.of(context).primaryColor.withOpacity(opacity),
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (int i) {
            this._selectTab(i);
          },
          items: <Widget>[
            Icon(
              Icons.home,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            Icon(
              Icons.history,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            Icon(
              Icons.notifications,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            Icon(
              Icons.settings,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
