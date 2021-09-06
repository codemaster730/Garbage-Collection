import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/helper.dart';
import '../helpers/swipe_widget.dart';
import '../models/notification.dart' as model;

class NotificationItemWidget extends StatelessWidget {
  final model.Notification notification;
  final VoidCallback onMarkAsRead;
  final VoidCallback onMarkAsUnRead;
  final VoidCallback onRemoved;

  NotificationItemWidget(
      {Key key,
      this.notification,
      this.onMarkAsRead,
      this.onMarkAsUnRead,
      this.onRemoved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnSlide(
      // backgroundColor: notification.read
      //     ? Theme.of(context).scaffoldBackgroundColor
      //     : Theme.of(context).primaryColor.withAlpha(30),
      items: <ActionItems>[
        ActionItems(
            icon: notification.read
                ? new Icon(
                    Icons.panorama_fish_eye,
                    color: Theme.of(context).primaryColor,
                  )
                : new Icon(
                    Icons.brightness_1,
                    color: Theme.of(context).primaryColor,
                  ),
            onPress: () {
              if (notification.read) {
                onMarkAsUnRead();
              } else {
                onMarkAsRead();
              }
            },
            backgroudColor: Theme.of(context).scaffoldBackgroundColor),
        new ActionItems(
            icon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child:
                  new Icon(Icons.delete, color: Theme.of(context).primaryColor),
            ),
            onPress: () {
              onRemoved();
            },
            backgroudColor: Theme.of(context).scaffoldBackgroundColor),
      ],
      child: Container(
        decoration: BoxDecoration(
          color: notification.read
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).primaryColor.withAlpha(30),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[100], blurRadius: 13, offset: Offset(0, 3))
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            notification.read
                                ? Theme.of(context).focusColor.withOpacity(0.7)
                                : Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.7),
                            notification.read
                                ? Theme.of(context).focusColor.withOpacity(0.07)
                                : Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.07),
                            // Theme.of(context).focusColor.withOpacity(0.05),
                          ])),
                  child: Icon(
                    Icons.notifications,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 30,
                  ),
                ),
                Positioned(
                  right: -30,
                  bottom: -50,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.15),
                      borderRadius: BorderRadius.circular(150),
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  top: -50,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.15),
                      borderRadius: BorderRadius.circular(150),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(width: 15),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  notification.type == null
                      ? Text("")
                      : Text(
                          Helper.of(context).trans(notification.type),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.justify,
                          style: Theme.of(context).textTheme.bodyText1.merge(
                              TextStyle(
                                  color: Colors.grey,
                                  fontWeight: notification.read
                                      ? FontWeight.w300
                                      : FontWeight.w600)),
                        ),
                  Html(
                    data: "<div>" +
                        notification.data['message'].toString() +
                        "<\/div>",
                    style: {
                      "div": Style(
                        // padding: EdgeInsets.all(6),
                        color: Colors.grey,
                      )
                    },
                    onLinkTap: (String url) {
                      launch(url);
                    },
                  ),
                  // Text(
                  //   notification.data['message'].toString(),
                  //   overflow: TextOverflow.ellipsis,
                  //   maxLines: 2,
                  //   textAlign: TextAlign.justify,
                  //   style: Theme.of(context).textTheme.bodyText1.merge(
                  //       TextStyle(
                  //           fontSize: 14,
                  //           color: Colors.grey,
                  //           fontWeight: notification.read
                  //               ? FontWeight.w300
                  //               : FontWeight.w600)),
                  // ),
                  Text(
                    DateFormat('yyyy-MM-dd | HH:mm')
                        .format(notification.createdAt),
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
