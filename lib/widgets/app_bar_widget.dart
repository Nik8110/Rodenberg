import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/screens/order/cart_screen.dart';
import 'package:rodenberg/services/cart_service/cart_service.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/asset_constant.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final List<Widget> leading;
  const CustomAppBar({Key? key, this.leading = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      titleSpacing: 0,
      backgroundColor: AppColors.primaryColor,
      title: Image.asset(
        AssetConstant.logo,
        height: 40.h,
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(45.h),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 20.h,
                    padding: EdgeInsets.symmetric(horizontal: 9.h),
                    child: TextField(
                      style: Get.textTheme.bodyText2?.copyWith(fontSize: 12.sp),
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 8.5.h),
                        border: InputBorder.none,
                        hintStyle: Get.textTheme.bodyText2?.copyWith(
                            fontSize: 12.sp, color: AppColors.textColor1),
                        hintText: "What are you looking for?".tr(),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(1),
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.primaryColor),
                  child: Image.asset(
                    AssetConstant.search,
                    width: 15.h,
                    height: 15.h,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => Get.off(() => const CartScreen()),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  AssetConstant.cart,
                  height: 20.h,
                  width: 20.h,
                  color: Colors.white,
                ),
              ),
              Positioned(
                bottom: 2.h,
                left: 2,
                child: Obx(
                  () => Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: AppColors.orange, shape: BoxShape.circle),
                    child: Text(
                      "${CartService.to.cartItems.length}",
                      style: Get.textTheme.bodyText2
                          ?.copyWith(fontSize: 8.sp, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        ...leading,
        SizedBox(
          width: 20.w,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 45.h);
}
