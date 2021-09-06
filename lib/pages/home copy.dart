import 'package:flutter/material.dart';
import '../models/route_argument.dart';
import '../helpers/helper.dart';
import './search.dart';
import './history.dart';
import './notification.dart';
import './setting.dart';

// ignore: must_be_immutable
class HomeWidget extends StatefulWidget {
  dynamic currentTab;
  RouteArgument routeArgument;
  Widget currentPage = SearchWidget();
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
          widget.currentPage = SearchWidget(
            parentScaffoldKey: widget.scaffoldKey,
          );
          break;
        case 1:
          widget.currentPage = HistoryWidget(
            parentScaffoldKey: widget.scaffoldKey,
          );
          break;
        case 2:
          widget.currentPage = NotificationWidget(
            parentScaffoldKey: widget.scaffoldKey,
          );

          break;
        case 3:
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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 24,
          elevation: 0,
          backgroundColor: Colors.grey.shade200,
          selectedIconTheme: IconThemeData(size: 30),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: widget.currentTab,
          onTap: (int i) {
            this._selectTab(i);
          },
          items: [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                ],
              ),
              activeIcon: Column(
                children: [
                  Icon(
                    Icons.home,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(
                    Icons.notifications,
                    color: Colors.grey,
                  ),
                ],
              ),
              activeIcon: Column(
                children: [
                  Icon(
                    Icons.notifications,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ],
              ),
              activeIcon: Column(
                children: [
                  Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
              label: 'Profiles',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.grey,
                  ),
                ],
              ),
              activeIcon: Column(
                children: [
                  Icon(
                    Icons.settings,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
