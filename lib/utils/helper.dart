import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:place_picker/place_picker.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/app_constant.dart';

class Helper{

  static void showSnackbar(String title,String message){
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primaryColor,
      colorText: Colors.white,
      duration: 2.seconds
    );
  }

  static String getImage(LatLng latLng){
    return "https://maps.googleapis.com/maps/api/staticmap?center=${latLng.latitude},${latLng.longitude}&zoom=15&scale=1&size=600x250&maptype=roadmap&key="+AppConstant.MAP_API_KEY+"&format=png&visual_refresh=true&markers=size:mid%7Ccolor:0x25873c%7Clabel:%7C${latLng.latitude},${latLng.longitude}";
  }

  static showLanguageSelector(){

    Get.dialog(AlertDialog(
      title: Center(child: Text("Choose Language".tr())),
      backgroundColor: Colors.white,
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
                onTap: ()async{
                  var locale = const Locale("en");
                    await Get.context?.setLocale(locale);
                    Get.updateLocale(locale);
                    Get.back();
                },
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("English".tr()),
            )),
            const Divider(),
            InkWell(
                onTap: ()async{
                  var locale = const Locale("es");
                  await Get.context?.setLocale(locale);
                  Get.updateLocale(locale);
                  Get.back();
                },
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Spanish".tr()),
            ))
          ],
        ),
      ),
    ));

  }
}