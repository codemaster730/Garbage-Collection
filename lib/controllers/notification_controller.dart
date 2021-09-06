import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../generated/l10n.dart';
import '../models/notification.dart' as model;
import '../repository/notification_repository.dart';
import '../helpers/api.dart';

class NotificationController extends ControllerMVC {
  List<model.Notification> notifications = <model.Notification>[];
  int unReadNotificationsCount = 0;
  GlobalKey<ScaffoldState> scaffoldKey;

  NotificationController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForNotifications();
  }

  void listenForNotifications({String message}) async {
    List<Widget> oList = new List<Widget>();
    dynamic listData;
    // listData = Api().getApiData('/get_notification');
    listData = await getNotifications();
    if (listData['success'] == true) {
      for (var item in listData['data']) {
        setState(() {
          notifications.add(model.Notification.fromJSON(item));
        });
      }
      // scaffoldKey?.currentState?.showSnackBar(SnackBar(
      //   content: Text(message),
      // ));
    }
  }

  Future<void> refreshNotifications() async {
    notifications.clear();
    listenForNotifications(
        message: S.of(context).notifications_refreshed_successfuly);
  }

  void doMarkAsReadNotifications(model.Notification _notification) async {
    markAsReadNotifications(_notification).then((value) {
      setState(() {
        --unReadNotificationsCount;
        _notification.read = !_notification.read;
      });
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).thisNotificationHasMarkedAsRead),
      ));
    });
  }

  void doMarkAsUnReadNotifications(model.Notification _notification) {
    markAsReadNotifications(_notification).then((value) {
      setState(() {
        ++unReadNotificationsCount;
        _notification.read = !_notification.read;
      });
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).thisNotificationHasMarkedAsUnread),
      ));
    });
  }
/*
  void doRemoveNotification(model.Notification _notification) async {
    removeNotification(_notification).then((value) {
      setState(() {
        if (!_notification.read) {
          --unReadNotificationsCount;
        }
        this.notifications.remove(_notification);
      });
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).notificationWasRemoved),
      ));
    });
  }
  */
}
