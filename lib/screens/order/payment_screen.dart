import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/order_controller.dart';
import 'package:rodenberg/services/cart_service/cart_service.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/widgets/app_bar_widget.dart';
import 'package:rodenberg/widgets/app_button.dart';
import 'package:rodenberg/widgets/drawer_widget.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedOption = 'COD';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Obx(
          () => SizedBox(
            width: Get.width,
            height: Get.height - Get.statusBarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      const Icon(
                        Icons.chevron_left,
                        color: Colors.black54,
                      ),
                      Text(
                        "Back".tr(),
                        style: Get.textTheme.bodyText2
                            ?.copyWith(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 0.5,
                  color: Colors.black87,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Payment".tr(),
                    style:
                        Get.textTheme.bodyText2?.copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: AppColors.primaryColor,
                            value: 'COD',
                            groupValue: selectedOption,
                            onChanged: (String? str) {
                              setState(() {
                                selectedOption = str!;
                              });
                            },
                          ),
                          Text(
                            "COD".tr(),
                            style: Get.textTheme.bodyText2!.copyWith(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: AppColors.primaryColor,
                            value: "Mercado Pago en Línea",
                            groupValue: selectedOption,
                            onChanged: (String? str) {
                              setState(() {
                                selectedOption = str!;
                              });
                            },
                          ),
                          Text(
                            "Mercado Pago en Línea".tr(),
                            style: Get.textTheme.bodyText2!.copyWith(),
                          ),
                        ],
                      ),
                      Transform.scale(
                          scale: 0.7,
                          child: AppButton(
                            label: "Pay".tr(),
                            onTap: () async {
                              if (selectedOption == "COD") {
                                await OrderController.to.placeOrder();
                              } else {
                                await OrderController.to.onlinePayment();
                              }
                            },
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Payment Details".tr()),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "Total Price".tr(),
                            style: Get.textTheme.bodyText2!
                                .copyWith(fontSize: 12.sp),
                          ),
                          const Spacer(),
                          Text(
                            "\$ ${CartService.to.subTotal.value}",
                            style: Get.textTheme.bodyText2!
                                .copyWith(fontSize: 12.sp),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Text(
                            "Discount".tr(),
                            style: Get.textTheme.bodyText2!
                                .copyWith(fontSize: 12.sp),
                          ),
                          const Spacer(),
                          Text(
                            "- \$ ${CartService.to.discountTotal.value}",
                            style: Get.textTheme.bodyText2!
                                .copyWith(fontSize: 12.sp),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Text(
                            "VAT".tr(),
                            style: Get.textTheme.bodyText2!
                                .copyWith(fontSize: 12.sp),
                          ),
                          const Spacer(),
                          Text(
                            "\$ ${CartService.to.taxValue.value}",
                            style: Get.textTheme.bodyText2!
                                .copyWith(fontSize: 12.sp),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Text(
                            "Total Amount".tr(),
                            style: Get.textTheme.bodyText2!
                                .copyWith(fontSize: 12.sp),
                          ),
                          const Spacer(),
                          Text(
                            "\$ ${CartService.to.grandTotal.value}",
                            style: Get.textTheme.bodyText2!
                                .copyWith(fontSize: 12.sp),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
