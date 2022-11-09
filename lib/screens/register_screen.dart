import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/auth_controller.dart';
import 'package:rodenberg/screens/login_screen.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/asset_constant.dart';
import 'package:rodenberg/utils/helper.dart';
import 'package:rodenberg/widgets/app_button.dart';
import 'package:rodenberg/widgets/input_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final TextEditingController  nameController = TextEditingController();
  final TextEditingController  phoneController = TextEditingController();
  final TextEditingController  emailController = TextEditingController();
  final TextEditingController  passwordController = TextEditingController();
  final TextEditingController  confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h,),
              Image.asset(AssetConstant.logo,width: Get.width*0.4,),
              SizedBox(height: 20.h,),
              Text("Register".tr(),style: Get.textTheme.bodyText1?.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 20.sp
              ),),
              SizedBox(height: 20.h,width: Get.width,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  children: [
                    InputWidget(label: "Name".tr(),hint:"(e.g.: John Due)".tr(),controller: nameController,),
                    SizedBox(height: 15.h,),
                    InputWidget(label: "Phone".tr(),hint:"(e.g.: +56988197893)".tr(),controller: phoneController,),
                    SizedBox(height: 15.h,),
                    InputWidget(label: "e-Mail".tr(),hint:"(e.g.: john@example.com)".tr(),controller: emailController,),
                    SizedBox(height: 15.h,),
                    InputWidget(label: "Password".tr(),controller: passwordController,
                      isPassword: true,
                    ),
                    SizedBox(height: 15.h,),
                    InputWidget(label: "Confirm Password".tr(),controller: confirmPasswordController,
                      isPassword: true,
                    ),
                    SizedBox(height: 50.h,),
                    AppButton( label: "Register".tr(),onTap: ()async{

                      if(nameController.text.isEmpty) return Helper.showSnackbar("Error".tr(), "Enter valid name".tr());
                      if(phoneController.text.isEmpty || phoneController.text.length.isLowerThan(8) || phoneController.text.length.isGreaterThan(12)) return Helper.showSnackbar("Error".tr(), "Enter valid phone number".tr());
                      if(!emailController.text.isEmail) return Helper.showSnackbar("Error".tr(), "Enter valid email".tr());
                      if(passwordController.text.isEmpty || passwordController.text.length.isLowerThan(5)) return Helper.showSnackbar("Error".tr(), "Password should be atleast 6 character long".tr());
                      if(passwordController.text != confirmPasswordController.text) return Helper.showSnackbar("Error".tr(), "Password and Confirm password should be same".tr());


                      await AuthController.to.signup(nameController.text, emailController.text, passwordController.text, confirmPasswordController.text, phoneController.text);

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
