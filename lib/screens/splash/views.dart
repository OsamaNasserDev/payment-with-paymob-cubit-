import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../helper/cache_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/assets_manager.dart';
import '../../utils/color_manager.dart';
import '../Payment/view.dart';



class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>  InfoScreen(),
          ),
              (route) => false);
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  ColorManager.white,
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(ImageAssets.splashLogo,),
            //     //fit: BoxFit.fitWidth,
            //   ),
            // ),
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(ImageAssets.splashLogo,height: 200,width: 200,),
                const SizedBox(height: 30),
                SpinKitWanderingCubes(
                  color: ColorManager.primary,
                  size: 30.0,
                ),
              ],
            ),

          ),
        )
    );
  }
}
