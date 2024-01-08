import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_page/firebase_options.dart';
import 'package:login_page/image_picker.dart';
import 'package:login_page/logIn_page.dart';
import 'package:login_page/observation_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized() ;
  await  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  ) ;
 // await FirebaseAppCheck.instance.activate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context , orientation , screenType) {
      return MaterialApp(
      // locale: DevicePreview.locale(context),
       //   builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const LogInPage(),
        );
      },
    );
  }
}

