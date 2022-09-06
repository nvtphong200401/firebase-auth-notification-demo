import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:demo_firebase/domain/controllers/noti_controller.dart';
import 'package:demo_firebase/presentation/message_screen.dart';
import 'package:demo_firebase/presentation/login_screen.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis_auth/auth.dart';

import 'data/model/message_model.dart';
import 'domain/controllers/message_controller.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage event) async {
  final body = event.data['body'];
  final title = event.data['title'];
  await AwesomeNotifications().createNotification(content: NotificationContent(
      id: DateTime.now().millisecond,
      channelKey: 'basic_channel', title: title , body: body!),
      actionButtons: [
        NotificationActionButton(key: 'REPLY', label: 'REPLY', buttonType: ActionButtonType.InputField, autoDismissible: true)
      ]
  );

  // ref.read(messageController).add(MessageModel(title: event.data['title'], body: event.data['body']));

}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotiController.init();

  // app.auth().generateSignInWithEmailLink(email, actionCodeSettings)
  await NotiController.getAccessToken();
  print(NotiController.token);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  @override
  void dispose(){
    print('Dispose');
    AwesomeNotifications().actionSink.close();
    super.dispose();
  }
  // Future createNoti(event) async {
  //   final body = event.data['body'];
  //   final title = event.data['title'];
  //   await AwesomeNotifications().createNotification(content: NotificationContent(
  //       id: 10,
  //       channelKey: 'basic_channel', title: title , body: body!),
  //       actionButtons: [
  //         NotificationActionButton(key: 'REPLY', label: 'REPLY', buttonType: ActionButtonType.InputField, autoDismissible: true)
  //       ]
  //   );
  //
  //
  // }

  @override
  void initState(){
    super.initState();
    // FirebaseMessaging.instance.onTokenRefresh.listen((event) {
    //   print(event);
    // });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler
      // if(event.data != null){
      //
      //   final body = event.data['body'];
      //   final title = event.data['title'];
      //   await AwesomeNotifications().createNotification(content: NotificationContent(
      //       id: 10,
      //       channelKey: 'basic_channel', title: title , body: body!),
      //       actionButtons: [
      //         NotificationActionButton(key: 'REPLY', label: 'REPLY', buttonType: ActionButtonType.InputField, autoDismissible: true)
      //       ]
      //   );
      //
      //   ref.read(messageController).add(MessageModel(title: event.data['title'], body: event.data['body']));
      //
      // }
    );

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if(event.data['route']){
        Navigator.of(context).push(event.data['route']);
      }
    });
    FirebaseMessaging.onMessage.listen((event) async {
      final notification = event.notification;
      final body = event.data['body'];
      final title = event.data['title'];


      await AwesomeNotifications().createNotification(content: NotificationContent(
          id: DateTime.now().microsecond,
          channelKey: 'basic_channel', title: title , body: body, groupKey: 'group_2'),
          actionButtons: [
            NotificationActionButton(key: 'REPLY', label: 'REPLY', buttonType: ActionButtonType.InputField, autoDismissible: true)
      ]
      );
      //print('milisec 1 #')
      // await Future.delayed(Duration(milliseconds: 500));
      await AwesomeNotifications().createNotification(content: NotificationContent(
          id: DateTime.now().microsecond,
          channelKey: 'basic_channel', title: title , body: body, groupKey: 'group_3'),
          actionButtons: [
            NotificationActionButton(key: 'REPLY', label: 'REPLY', buttonType: ActionButtonType.InputField, autoDismissible: true)
          ]
      );

      ref.read(messageController).add(MessageModel(title: event.data['title'], body: event.data['body']));
    });
    AwesomeNotifications().actionStream.listen((event) {
      if (event.buttonKeyPressed == 'REPLY') {
        ref.read(messageController).sendNotification(
            'Phongdz', event.buttonKeyInput);
        // ref.read(messageController).add(MessageModel(title: 'Phongdz', body: event.buttonKeyInput));
      }
    }, cancelOnError: false);
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
