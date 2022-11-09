import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/home_controller.dart';
import 'package:rodenberg/helper/location_helper.dart';
import 'package:rodenberg/screens/home_screen.dart';
import 'package:rodenberg/screens/login_screen.dart';
import 'package:rodenberg/screens/others/no_internet_screen.dart';
import 'package:rodenberg/utils/asset_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if(result==ConnectivityResult.none){
        Get.offAll(()=>const NoInternetScreen());
      }
    });

    Future.delayed(2.seconds,initLocation);
  }

  initLocation()async{
    LocationHelper.determinePosition().then((value)
    {
    Get.put(HomeController(),permanent: true);
    Get.off(()=>const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Center(
          child: Image.asset(AssetConstant.logo),
        ),
      ),
    );
  }
}
