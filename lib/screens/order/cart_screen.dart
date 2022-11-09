import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/order_controller.dart';
import 'package:rodenberg/controller/user_controller.dart';
import 'package:rodenberg/screens/add_new_address_screen.dart';
import 'package:rodenberg/screens/home_screen.dart';
import 'package:rodenberg/screens/login_screen.dart';
import 'package:rodenberg/screens/order/order_new_address_screen.dart';
import 'package:rodenberg/services/cart_service/cart_service.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/helper.dart';
import 'package:rodenberg/widgets/app_bar_widget.dart';
import 'package:rodenberg/widgets/app_button.dart';
import 'package:rodenberg/widgets/drawer_widget.dart';
import 'package:rodenberg/widgets/product_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: Obx(
        () => SizedBox(
          width: Get.width,
          height: Get.height - Get.statusBarHeight,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      GestureDetector(
                        onTap: () => Get.off(() => const HomeScreen()),
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
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: Colors.black87,
                      ),
                      CartService.to.cartItems.isNotEmpty
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: CartService.to.cartItems.length,
                                    itemBuilder: (context, index) {
                                      return ProductLandscapeWidget(
                                        product: CartService
                                            .to.cartItems[index].product,
                                      );
                                    }),
                              ],
                            )
                          : Column(
                              children: [
                                Center(
                                    child: Text(
                                  "No items in cart".tr(),
                                  style: Get.textTheme.bodyText1!.copyWith(),
                                )),
                              ],
                            ),
                      if (CartService.to.cartItems.isNotEmpty)
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
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
                                  Spacer(),
                                  Text(
                                    "\$ ${CartService.to.subTotal}",
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
                                    "- \$ ${CartService.to.discountTotal}",
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
                                    "\$ ${(CartService.to.taxValue.value)}",
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
              if (CartService.to.cartItems.isNotEmpty)
                Container(
                  padding: const EdgeInsets.only(bottom: 25, left: 20),
                  width: double.infinity,
                  height: 100.h,
                  color: const Color(0xFFE3E3E3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Payable Amount".tr(),
                            style: Get.textTheme.bodyText1!.copyWith(
                                color: AppColors.primaryColor, fontSize: 10.sp),
                          ),
                          Text(
                            "\$ ${CartService.to.grandTotal.value}",
                            style: Get.textTheme.bodyText1!.copyWith(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      Transform.scale(
                          scale: 0.8,
                          child: AppButton(
                            label: "Place Order".tr(),
                            onTap: () async => await confirmCart(),
                          ))
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  confirmCart() async {
    if (UserController.to.loggedIn.isTrue) {
      if (UserController.to.authUser.value!.deliveryAddress == null ||
          UserController.to.authUser.value!.deliveryAddress!.isEmpty) {
        var res = await Get.to(() => const AddNewAddressScreen());
        if (res == "success") await confirmCart();
        return;
      }
      print('GRAND TOTAL ++++++ ${CartService.to.grandTotal.value.toInt()}');
      print('MIN TOTAL ++++++ ${OrderController.to.minOrderValue}');
      print(
          'MIN TOTAL ++++++ ${CartService.to.grandTotal.value.toInt() < OrderController.to.minOrderValue}');
      if (CartService.to.grandTotal.value < OrderController.to.minOrderValue) {
        return Helper.showSnackbar(
            "Error".tr(),
            "Minimum order amount is {}"
                .tr(args: ["\$ ${OrderController.to.minOrderValue}"]));
      }
      // if(UserController.to.authUser.value!.rut==null||UserController.to.authUser.value!.rut!.isEmpty){
      //   var res = await Get.to(() => const OrderAddDetailsScreen());
      //   if (res == "success")  await confirmCart();
      //   return;
      // }
      // await OrderController.to.getDeliverySlots();
      // Get.to(()=>const DeliverySlotsScreen());
      Get.to(() => const OrderNewAddressScreen());
    } else {
      Get.off(() => LoginScreen());
    }
  }
}
