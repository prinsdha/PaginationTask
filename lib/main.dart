import 'dart:io';

import 'package:demotask/ui/auth/face_auth.dart';
import 'package:demotask/ui/global.dart';
import 'package:demotask/ui/home_screen/model/git_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core/constant/app_themes.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/bindings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await globalVerbInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return GetMaterialApp(
      builder: (context, child) => MediaQuery(
        child: child as Widget,
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      ),
      title: "DemoTask",
      initialBinding: BaseBinding(),
      debugShowCheckedModeBanner: false,
      initialRoute: FaceAuth.routeName,
      getPages: routes,
      theme: AppTheme.defTheme,
    );
  }
}
