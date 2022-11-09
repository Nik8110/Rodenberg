
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/auth_controller.dart';
import 'package:rodenberg/screens/home_screen.dart';
import 'package:rodenberg/screens/register_screen.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/asset_constant.dart';
import 'package:rodenberg/widgets/app_button.dart';
import 'package:rodenberg/widgets/input_widget.dart';

import 'login_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final TextEditingController email = TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.h,),
              Image.asset(AssetConstant.logo,width: Get.width*0.4,),
              SizedBox(height: 20.h,),
              Text("Forgot Password".tr(),style: Get.textTheme.bodyText1?.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 20.sp
              ),),
              SizedBox(height: 50.h,width: Get.width,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  children: [
                    InputWidget(label: "e-Mail".tr(),controller: email,),
                    SizedBox(height: 15.h,),

                    SizedBox(height: 55.h,),
                    AppButton(label: "Reset".tr(),onTap:  () async{

                      await AuthController.to.resetPassword(email.text);

                      // await Future.delayed(3.seconds);
                      // Get.to(()=>const HomeScreen());
                    },),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?".tr(),style: Get.textTheme.bodyText2?.copyWith(fontSize: 12.sp),),
                        GestureDetector(
                            onTap: ()=>Get.off(()=>LoginScreen()),
                            child: Text("Sign in".tr(),style: Get.textTheme.bodyText2?.copyWith(fontSize: 12.sp,color: AppColors.primaryColor),))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}
