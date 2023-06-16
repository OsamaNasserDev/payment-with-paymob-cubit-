import 'package:flutter/material.dart';
import 'package:payment_with_paymob/screens/splash/views.dart';
import 'package:payment_with_paymob/theme/dark_theme.dart';
import 'package:payment_with_paymob/theme/light_theme.dart';
import 'package:payment_with_paymob/utils/app_constants.dart';

import 'helper/cache_helper.dart';
import 'helper/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: AppConstants.APP_NAME,
        debugShowCheckedModeBanner: false,
        theme: light,
        //darkTheme: dark,
      home: SplashScreen(),
    );
  }
}
