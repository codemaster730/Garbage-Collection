import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:laji_proj/repository/order_repository.dart';
import 'package:laji_proj/repository/user_repository.dart';
import './api.dart';
import '../generated/l10n.dart';
import 'app_config.dart' as config;

class WidgetManage {
  List<Widget> getNotificationList(String apiUrl, BuildContext bContext) {
    List<Widget> oList = new List<Widget>();
    dynamic listData;
    listData = Api().getApiData(apiUrl);
    for (var item in listData['list']) {
      oList.add(
        FlatButton(
          onPressed: () {
            // print(item.toString());
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              // boxShadow: [
              //   BoxShadow(
              //     blurRadius: 10,
              //     color: Colors.black.withOpacity(0.2),
              //   )
              // ],
            ),
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.notifications,
                          color: Theme.of(bContext).primaryColor,
                          size: 30,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          item['noti_contents'],
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(bContext).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    // print(listData.toString());
    return oList;
  }

  Widget getItemWidget(BuildContext bContext, dynamic item) {
    return ListTile(
      onTap: () {
        Navigator.of(bContext).pushNamedAndRemoveUntil(
            '/orderDetail', (Route<dynamic> route) => true,
            arguments: item);
      },
      leading: SizedBox(
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          child: Image(
            image: item['has_media'] == true
                ? NetworkImage(
                    item['media'][0]['url'],
                  )
                : AssetImage(
                    "assets/img/splash1.png",
                  ),
            width: config.App(bContext).appWidth(20),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Row(
        children: [
          Text(
            S.of(bContext).order + " #" + item['id'].toString(),
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          // Text(
          //   "(" +
          //       currentData.value['order_state']
          //           [item['order_status_id'].toString()] +
          //       ")",
          //   style: TextStyle(
          //     fontSize: 12,
          //   ),
          // ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['delivery_address']['address'].toString(),
            style: TextStyle(
              fontSize: 10,
            ),
          ),
          (item['order_status_id'] < 3)
              ? Text("")
              : RatingBarIndicator(
                  rating: double.parse(item['rate'].toString()),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 22.0,
                  // direction: Axis.vertical,
                ),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            S.of(bContext).est_price +
                ": ¥" +
                item['payment']['estimated_price'].toString(),
            style: TextStyle(fontSize: 12, color: Colors.red),
          ),
          item['order_status_id'] > 2
              ? Text(
                  S.of(bContext).confirmed_price +
                      ": ¥" +
                      item['payment']['price'].toString(),
                  style: TextStyle(fontSize: 12, color: Colors.red),
                )
              : SizedBox(),
          item['order_status_id'] > 2
              ? Text(
                  S.of(bContext).final_price +
                      ": ¥" +
                      item['payment']['final_price'].toString(),
                  style: TextStyle(fontSize: 12, color: Colors.red),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  List<Widget> getOrderList(
      String orderState, BuildContext bContext, dynamic value) {
    List<Widget> oList = [];
    for (int i = 0; i < value['data'].length; i++) {
      if (value['data'][i]['order_status_id'].toString() == orderState) {
        oList.add(
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: getItemWidget(bContext, value['data'][i])),
        );
      }
    }
    if (oList.length == 0) {
      oList.add(Text("No order!"));
    }
    return oList;
  }

  List<Widget> getPlacedOrderList(
      String orderState, BuildContext bContext, dynamic value) {
    List<Widget> oList = [];
    for (int i = 0; i < value['data'].length; i++) {
      if (value['data'][i]['order_status_id'].toString() == orderState) {
        oList.add(
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: getItemWidget(bContext, value['data'][i])),
        );
      }
    }
    if (oList.length == 0) {
      oList.add(Text("No order!"));
    }
    return oList;
  }
}
