import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/user_controller.dart';
import 'package:rodenberg/screens/home_screen.dart';
import 'package:rodenberg/screens/order/order_add_details_screen.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/asset_constant.dart';
import 'package:rodenberg/widgets/app_bar_widget.dart';
import 'package:rodenberg/widgets/app_button.dart';
import 'package:rodenberg/widgets/drawer_widget.dart';

import '../add_new_address_screen.dart';

class OrderAddressScreen extends StatefulWidget {
  const OrderAddressScreen({Key? key}) : super(key: key);

  @override
  State<OrderAddressScreen> createState() => _OrderAddressScreenState();
}

class _OrderAddressScreenState extends State<OrderAddressScreen> {
  String selectedAddress = "";

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
              child: Text("Select Address".tr(),style: Get.textTheme.bodyText2?.copyWith(color: Colors.black),),
            ),
            SizedBox(height: 10.h,),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: ()=>Get.to(()=>const AddNewAddressScreen()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.primaryColor)
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.add,color: AppColors.primaryColor,),
                          SizedBox(width: 10.w,),
                          Text("Add New Address".tr(),style: Get.textTheme.bodyText2?.copyWith(color: AppColors.primaryColor),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedAddress = "1";
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.primaryColor)
                      ),
                      child: Row(
                        children: [
                          Radio(
                            activeColor: AppColors.primaryColor,
                              value: "1", groupValue: selectedAddress, onChanged: (val){
                            setState(() {
                              selectedAddress = val.toString();
                            });
                          }),
                          SizedBox(width: 10.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("${UserController.to.authUser.value!.name}",style: Get.textTheme.bodyText1?.copyWith(color: AppColors.black),),
                                  SizedBox(width: 10.w,),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text("Home".tr(),style: Get.textTheme.bodyText2!.copyWith(
                                      color: Colors.white,
                                      fontSize: 10.sp
                                    ),),
                                  ),

                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Text("Street 1275, City, New York, USA",style: Get.textTheme.bodyText2?.copyWith(color: Colors.grey),
                                maxLines: 1,),
                              Text("987-273-7288",style: Get.textTheme.bodyText2?.copyWith(color: Colors.black87), maxLines: 1,),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedAddress = "2";
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.primaryColor)
                      ),
                      child: Row(
                        children: [
                          Radio(
                              activeColor: AppColors.primaryColor,
                              value: "2", groupValue: selectedAddress, onChanged: (val){
                            setState(() {
                              selectedAddress = val.toString();
                            });
                          }),
                          SizedBox(width: 10.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("${UserController.to.authUser.value!.name}",style: Get.textTheme.bodyText1?.copyWith(color: AppColors.black),),
                                  SizedBox(width: 10.w,),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 5),
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text("Work",style: Get.textTheme.bodyText2!.copyWith(
                                        color: Colors.white,
                                        fontSize: 10.sp
                                    ),),
                                  ),

                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Text("Street 1275, City, New York, USA",style: Get.textTheme.bodyText2?.copyWith(color: Colors.grey),
                                maxLines: 1,),
                              Text("987-273-7288",style: Get.textTheme.bodyText2?.copyWith(color: Colors.black87), maxLines: 1,),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  AppButton(label: "Deliver Here",onTap: ()async{

                    Get.to(()=>const OrderAddDetailsScreen());
                  },)
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}


