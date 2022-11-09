import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/user_controller.dart';
import 'package:rodenberg/helper/location_helper.dart';
import 'package:rodenberg/screens/add_new_address_screen.dart';
import 'package:rodenberg/screens/delivery_address_screen.dart';
import 'package:rodenberg/screens/edit_profile_screen..dart';
import 'package:rodenberg/screens/home_screen.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/asset_constant.dart';
import 'package:rodenberg/widgets/app_bar_widget.dart';
import 'package:rodenberg/widgets/drawer_widget.dart';

import '../services/api_service/urls.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${UserController.to.authUser.value!.name}",style: Get.textTheme.bodyText2!.copyWith(fontSize: 14.sp),),
                          SizedBox(width: 5.w,),
                          GestureDetector(
                              onTap: ()=>Get.to(()=>const EditProfileScreen()),
                              child: Text("Edit".tr(),style: Get.textTheme.bodyText2!.copyWith(fontSize: 10.sp, color: AppColors.primaryColor),)),
                        ],
                      ),
                      Text(UserController.to.authUser.value!.address??LocationHelper.currentCity,style: Get.textTheme.bodyText2!.copyWith(fontSize: 10.sp),),
                    ],
                  ),

                  const Spacer(),
                  Container(
                    height: 35.h,
                    width: 35.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (UserController.to.authUser.value!.image==null)
                            ? const AssetImage(AssetConstant.avatar)
                            : NetworkImage(URLS.IMAGE_BASE_URL+UserController.to.authUser.value!.image!) as ImageProvider
                      )
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 5.h,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.w),
              color: Colors.white,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: ()=>Get.to(()=>const AddNewAddressScreen()),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.location_city,color: AppColors.primaryColor,),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text("Delivery Address".tr(),style: Get.textTheme.bodyText2?.copyWith(fontSize: 12.sp),)
                        ],
                      ),
                    ),
                  ),
                  const Divider(thickness: 0.3,color: Colors.black87,),
                  GestureDetector(
                    onTap: ()=>UserController.to.logoutDialog(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.logout,color: AppColors.primaryColor,),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text("Sign out".tr(),style: Get.textTheme.bodyText2?.copyWith(fontSize: 12.sp),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}


