import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/utils/asset_constant.dart';
import 'package:rodenberg/widgets/app_button.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetConstant.logo,width: Get.width*.45,),
            SizedBox(height: 50.h,),
            Text("Internet service is required\nto use app. Please connect to internet to continue.".tr(),
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyText1?.copyWith(
                  fontSize: 18.sp,
                  color: Colors.grey

              ),),
            SizedBox(height: 50.h,),
            AppButton(label: "Exit".tr(),onTap: ()async{
              Future.delayed(const Duration(milliseconds: 1000), () {
                exit(0);
              });
            },)
          ],
        ),
      ),
    );
  }
}
