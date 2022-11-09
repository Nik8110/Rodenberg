import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/screens/home_screen.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/asset_constant.dart';
import 'package:rodenberg/widgets/app_bar_widget.dart';
import 'package:rodenberg/widgets/drawer_widget.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

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
            SizedBox(height: 5.h,),
            GestureDetector(
              onTap: ()=>Get.off(()=>const HomeScreen()),
              child: Row(
                children: [
                  SizedBox(width: 10.w,),
                  const Icon(Icons.chevron_left,color: Colors.black54,),
                  Text("Back".tr(),style: Get.textTheme.bodyText2?.copyWith(color: Colors.black54),)
                ],
              ),
            ),
            const Divider(thickness: 0.5,color: Colors.black87,),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 20.w),
              child: Text("Contact Information".tr(),style: Get.textTheme.bodyText2?.copyWith(color: Colors.black),),
            ),
            SizedBox(height: 5.h,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.w),
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.phone,color: AppColors.primaryColor,),
                        const Spacer(),
                        Text("95328 15722",style: Get.textTheme.bodyText2?.copyWith(fontSize: 12.sp),)
                      ],
                    ),
                  ),
                  const Divider(thickness: 0.3,color: Colors.black87,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.mail,color: AppColors.primaryColor,),
                        const Spacer(),
                        Text("dairy@gmail.com",style: Get.textTheme.bodyText2?.copyWith(fontSize: 12.sp),)
                      ],
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


