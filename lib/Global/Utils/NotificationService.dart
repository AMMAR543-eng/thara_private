// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import '../Constatnts/TextConstants.dart';
// import '../Localization/LocalStorage_language.dart';
//
// class NotificationService {
//   // FirebaseMessaging messaging = FirebaseMessaging.instance;
//   //
//   // Future<void> initialNotificationService() async {
//   //   await askForPermission();
//   //   await handleBackgroundNotification();
//   //   await handleForgroundNotification();
//   //   if (topicName() != "") {
//   //     await subscripeToTopic(topicName());
//   //   }
//   // }
//   //
//   // Future<void> subscripeToTopic(String topicName) async {
//   //   await FirebaseMessaging.instance.subscribeToTopic(topicName);
//   // }
//   //
//   // Future<void> un_subscripeToTopic(String topicName) async {
//   //   await FirebaseMessaging.instance.unsubscribeFromTopic(topicName);
//   // }
//   //
//   // String topicName({String? relation}) {
//   //   UserClient userData = UserClient.fromJson(LocalStorage().read(Strings.model));
//   //   LocalStorage_language localStorage_language = LocalStorage_language();
//   //   String? current_relation = relation ?? userData.name;
//   //   String topic = current_relation ?? "";
//   //
//   //   if (localStorage_language.read() == "ar") {
//   //     if (current_relation == "guest_user") {
//   //       topic = "guest_user_ar";
//   //     } else if (current_relation == "father") {
//   //       topic = "father_ar";
//   //     } else if (current_relation == "mother") {
//   //       topic = "mother_ar";
//   //     } else if (current_relation == "nanny") {
//   //       topic = "nanny_ar";
//   //     } else if (current_relation == "teacher") {
//   //       topic = "teacher_ar";
//   //     }
//   //   } else {
//   //     if (current_relation == "guest_user") {
//   //       topic = "guest_user_en";
//   //     } else if (current_relation == "father") {
//   //       topic = "father_en";
//   //     } else if (current_relation == "mother") {
//   //       topic = "mother_en";
//   //     } else if (current_relation == "nanny") {
//   //       topic = "nanny_en";
//   //     } else if (current_relation == "teacher") {
//   //       topic = "teacher_en";
//   //     }
//   //   }
//   //   return topic;
//   // }
//   //
//   // Future<void> askForPermission() async {
//   //   NotificationSettings settings = await messaging.requestPermission(
//   //     alert: true,
//   //     announcement: false,
//   //     badge: true,
//   //     carPlay: false,
//   //     criticalAlert: false,
//   //     provisional: false,
//   //     sound: true,
//   //   );
//   //
//   //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//   //   } else if (settings.authorizationStatus ==
//   //       AuthorizationStatus.provisional) {
//   //   } else {
//   //   }
//   // }
//   //
//   // Future<void> handleBackgroundNotification() async {
//   //   // Get any messages which caused the application to open from
//   //   // a terminated state.
//   //   RemoteMessage? initialMessage =
//   //       await FirebaseMessaging.instance.getInitialMessage();
//   //
//   //   // If the message also contains a data property with a "type" of "chat",
//   //   // navigate to a chat screen
//   //   if (initialMessage != null) {
//   //     _handleMessageNavigation(initialMessage);
//   //   }
//   //
//   //   // Also handle any interaction when the app is in the background via a
//   //   // Stream listener
//   //   FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageNavigation);
//   // }
//   //
//   // Future<void> handleForgroundNotification() async {
//   //   // handle ios
//   //   await FirebaseMessaging.instance
//   //       .setForegroundNotificationPresentationOptions(
//   //     alert: true, // Required to display a heads up notification
//   //     badge: true,
//   //     sound: true,
//   //   );
//   //
//   //   // handle android
//   //   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   //     'high_importance_channel', // id
//   //     'High Importance Notifications', // title
//   //     importance: Importance.max,
//   //   );
//   //
//   //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   //   FlutterLocalNotificationsPlugin();
//   //
//   //   const androidSetting =
//   //   AndroidInitializationSettings('@mipmap/launcher_icon');
//   //   //  const iosSetting = IOSInitializationSettings();
//   //
//   //   // #2
//   //   const initSettings = InitializationSettings(android: androidSetting);
//   //
//   //   // #3
//   //   await flutterLocalNotificationsPlugin.initialize(initSettings).then((_) {
//   //     debugPrint('setupPlugin: setup success');
//   //   }).catchError((Object error) {
//   //     debugPrint('Error: $error');
//   //   });
//   //
//   //   await flutterLocalNotificationsPlugin
//   //       .resolvePlatformSpecificImplementation<
//   //       AndroidFlutterLocalNotificationsPlugin>()
//   //       ?.createNotificationChannel(channel);
//   //
//   //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//   //     RemoteNotification? notification = message.notification;
//   //     AndroidNotification? android = message.notification?.android;
//   //     _handleMessageNavigation(message);
//   //
//   //     // If `onMessage` is triggered with a notification, construct our own
//   //     // local notification to show to users using the created channel.
//   //     if (notification != null && android != null) {
//   //       flutterLocalNotificationsPlugin.show(
//   //           0,
//   //           notification.title,
//   //           notification.body,
//   //           NotificationDetails(
//   //             android: AndroidNotificationDetails(
//   //               channel.id,
//   //               channel.name,
//   //
//   //               icon: android.smallIcon,
//   //               // other properties...
//   //             ),
//   //           ));
//   //     }
//   //   });
//   // }
//   //
//   // Future<void> onSelectNotification(String? payload) async {
//   //   if (payload != null) {
//   //   }
//   // }
//   //
//   // Future<void> onDidReceiveLocalNotification(
//   //     int id, String title, String body, String payload) async {
//   // }
//   //
//   // void _handleMessageNavigation(RemoteMessage message) {
//   //   if (message.data['target'] == 'home') {
//   //     Get.offAll(
//   //         () => MainPage(
//   //               indexNum: 0,
//   //             ),
//   //         binding: Binding());
//   //   } else {
//   //     Get.offAll(
//   //         () => MainPage(
//   //               indexNum: 3,
//   //             ),
//   //         binding: Binding());
//   //   }
//   // }
// }
