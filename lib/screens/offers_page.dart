import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/home_controller.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/asset_constant.dart';
import 'package:rodenberg/widgets/app_bar_widget.dart';
import 'package:rodenberg/widgets/custom_image.dart';
import 'package:rodenberg/widgets/drawer_widget.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: HomeController.to.offerList.length.isGreaterThan(0)?ListView.builder(


        itemCount: HomeController.to.offerList.length,
        itemBuilder: (context,index) {
          var offer = HomeController.to.offerList[index];
          return Column(

            children: [

              SizedBox(height: 5.h,),
              CustomImage(url:"${offer.image}",width: double.infinity,height:150.h,fit: BoxFit.cover,borderRadius: 0,),

            ],
          );
        }
      ): Center(child: Text("No Offers".tr()),),
    );
  }
}


