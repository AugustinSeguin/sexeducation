import 'package:sexeducation/data/sexeducation_api_data_source.dart';
import 'package:sexeducation/models/notification_model.dart';
import 'package:sexeducation/services/authentication_service.dart';
import 'package:sexeducation/services/notifications/local_notification_service.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class NotificationsService {
  // PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  // final localNotificationService = LocalNotificationService();
  // NotificationsService() {
  //   localNotificationService.initialize();
  // }

  static Future<List<NotificationModel>?> getNotifications({bool? isRead}) async {
    // Load the notifications.json file
    final String response = await rootBundle.loadString('data/notifications.json');
    final List<dynamic> notificationsJson = json.decode(response);

    // Convert the JSON data to a list of NotificationModel objects
    final notifications = notificationsJson.map((notif) {
      return NotificationModel.fromJson(notif);
    }).toList();

    return notifications;
  }

  // Future<void> connectPusher() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final userId = prefs.getString('userId');

  //   try {
  //     await pusher.init(
  //       apiKey: dotenv.env['PUSHER_APP_KEY'].toString(),
  //       cluster: dotenv.env['PUSHER_APP_CLUSTER'].toString(),
  //       onEvent: onEvent,
  //       onAuthorizer: onAuthorizer,
  //     );

  //     // event new comment
  //     await pusher.subscribe(channelName: "private-comment.user.$userId");

  //     // event new like
  //     await pusher.subscribe(channelName: "private-like.user.$userId");

  //     // event new subscription : new subscription asked to user or subscription request's accepted
  //     await pusher.subscribe(channelName: "private-subscription.user.$userId");

  //     await pusher.connect();
  //   } catch (e) {
  //     debugPrint("ERROR: $e");
  //   }
  // }

  // disconnectPusher() async {
  //   await pusher.disconnect();
  // }

  // void onEvent(dynamic event) async {
  //   debugPrint(event.toString());

  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final userId = prefs.getString('userId');
  //   String? message = jsonDecode(event.data.toString())['message'].toString();



  //   if (message != "null") {
  //     if (event.channelName.toString().contains("private-subscription.user")) {
  //       // new subscription request for authenticated user
  //       var user =
  //           jsonDecode(event.data.toString())['subscription']['follower'];
  //       if (userId == user.id) {
  //         // the following accept user authenticated request subscription
  //         user =
  //             jsonDecode(event.data.toString())['subscription']['following'];
  //       }
  //       await localNotificationService.showNotificiation(
  //           id: user['id'], title: message, payload: "/users/${user['id']}");
  //     } else if (event.channelName.toString().contains("private-like.user") ||
  //         event.channelName.toString().contains("private-comment.user")) {
  //       final post = jsonDecode(event.data.toString())['post'];

  //       await localNotificationService.showNotificiation(
  //           id: post['id'], title: message, payload: "/posts/${post['id']}");
  //     }
  //   }
  // }

  // // getSignature(String value) {
  // //   final key = utf8.encode(dotenv.env['PUSHER_APP_SECRET'].toString());
  // //   final bytes = utf8.encode(value);

  //   final hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
  //   final digest = hmacSha256.convert(bytes);
  //   return digest;
  // }

  // dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
  //   return {
  //     "auth": "${dotenv.env['PUSHER_APP_KEY']}:${getSignature("$socketId:$channelName")}",
  //   };
  // }
}
