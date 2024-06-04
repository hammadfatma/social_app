import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/layouts/social_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/network/local/cach_helper.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
  print(message.data.toString());

  showToast(
    text: 'on background message',
    state: ToastStates.success,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // unique id for device
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  // foreground
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
    showToast(text: 'on message', state: ToastStates.success);
  });
  // when click on notification
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());
    showToast(text: 'on message opened app', state: ToastStates.success);
  });
  // background
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await CacheHelper.init();
  Widget widget;
  String? uId = CacheHelper.getData(key: 'uId');
  print(uId);
  if (uId != null) {
    widget = const SocialLayout();
  } else {
    widget = const LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
    uId: uId,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  final String? uId;
  const MyApp({super.key, this.startWidget, this.uId});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()
        ..getUserData(uId: uId)
        ..getPosts(),
      child: BlocBuilder<SocialCubit, SocialStates>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              fontFamily: 'Jannah',
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: startWidget,
          );
        },
      ),
    );
  }
}
