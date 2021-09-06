import 'package:flutter/material.dart';
import '../helpers/app_config.dart' as config;
import '../repository/user_repository.dart';
import '../helpers/widget_manage.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class NotificationWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  const NotificationWidget({
    Key key,
    this.parentScaffoldKey,
  }) : super(key: key);
  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  bool isPage = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _con.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.only(
            //   bottomRight: Radius.circular(20),
            // ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorDark,
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 3),
          child: Text(
            "Notification",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
      body: Container(
        child: ContainedTabBarView(
          tabBarProperties: TabBarProperties(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
          ),
          tabs: [
            Text(
              'All notification',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Messages',
              style: TextStyle(fontSize: 18),
            )
          ],
          views: [
            Container(
              height: config.App(context).appVerticalPadding(80),
              child: SingleChildScrollView(
                child: Column(
                  children: WidgetManage()
                      .getNotificationList("/get_notification", context),
                ),
              ),
            ),
            Text("Chat"),
          ],
          // onChange: (index) => print(index),
        ),
      ),
    );
  }
}
