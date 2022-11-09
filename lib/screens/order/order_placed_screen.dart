import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/screens/home_screen.dart';
import 'package:rodenberg/services/cart_service/cart_service.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/asset_constant.dart';
import 'package:rodenberg/widgets/app_button.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({Key? key}) : super(key: key);

  void goToHome(){
    CartService.to.cartItems.clear();
    Get.offAll(()=>const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
        goToHome();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Center(child: Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AssetConstant.check,color: AppColors.primaryColor,height: 100.h,),
                SizedBox(height: 20.h,),
                Text("Your order is confirmed".tr(),style: Get.textTheme.bodyText2!.copyWith(color: AppColors.primaryColor,fontSize: 18.sp),),
                SizedBox(height: 5.h,),
                // Text("Order ID: 237946182",style: Get.textTheme.bodyText2!.copyWith(color: AppColors.black,fontSize: 15.sp),),
                // SizedBox(height: 20.h,),
                Transform.scale(
                    scale: 0.8,
                    child: AppButton(label: "OK".tr(),onTap: ()async{
                      goToHome();
                    },),)
              ],
            ),
          )),
        ),
      ),
    );
  }
}
