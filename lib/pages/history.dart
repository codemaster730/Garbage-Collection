import 'package:flutter/material.dart';
import 'package:laji_proj/repository/order_repository.dart';
import '../helpers/app_config.dart' as config;
import '../repository/user_repository.dart';

import '../generated/l10n.dart';
import '../helpers/widget_manage.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class HistoryWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  const HistoryWidget({
    Key key,
    this.parentScaffoldKey,
  }) : super(key: key);
  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  bool isPage = false;

  @override
  void initState() {
    super.initState();
    getOrder();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: currentOrder,
        builder: (context, value, child) {
          return Scaffold(
            // key: _con.scaffoldKey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Container(
                padding: const EdgeInsets.only(left: 5.0, top: 3),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).my_orders,
                    style: Theme.of(context).textTheme.headline1,
                  ),
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
                    S.of(context).current_orders,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    S.of(context).pending_orders,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    S.of(context).completed_orders,
                    style: TextStyle(fontSize: 18),
                  )
                ],
                views: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children:
                            WidgetManage().getOrderList("2", context, value),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children:
                            WidgetManage().getOrderList("3", context, value),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children:
                            WidgetManage().getOrderList("4", context, value),
                      ),
                    ),
                  ),
                ],
                // onChange: (index) => print(index),
              ),
            ),
          );
        });
  }
}
