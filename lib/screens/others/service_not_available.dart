
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/helper/location_helper.dart';
import 'package:rodenberg/utils/asset_constant.dart';
import 'package:rodenberg/widgets/app_button.dart';

class ServiceNotAvailable extends StatelessWidget {
  const ServiceNotAvailable({Key? key}) : super(key: key);

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
            Text("We don't serve at {} yet".tr(args: [(LocationHelper.currentCity)]),
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
