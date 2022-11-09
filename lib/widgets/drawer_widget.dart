import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/user_controller.dart';
import 'package:rodenberg/screens/category_list_screen.dart';
import 'package:rodenberg/screens/contact_screen.dart';
import 'package:rodenberg/screens/home_screen.dart';
import 'package:rodenberg/screens/login_screen.dart';
import 'package:rodenberg/screens/offer_product_list_screen.dart';
import 'package:rodenberg/screens/order/order_history_screen.dart';
import 'package:rodenberg/screens/profile_screen.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/asset_constant.dart';
import 'package:rodenberg/utils/helper.dart';
import 'package:rodenberg/widgets/drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryColor,
      child: SafeArea(
        child: Obx(
          () => Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        right: 15,
                        top: 5,
                        child: InkWell(
                            onTap: () => Get.back(),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ))),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Image.asset(
                        AssetConstant.logo,
                        width: Get.width * 0.35,
                      ),
                    ),
                  ],
                ),
              ),
              if (UserController.to.loggedIn.isTrue)
                Text(
                  "Hello, {}"
                      .tr(args: [UserController.to.authUser.value!.name!]),
                  style: Get.textTheme.bodyText1
                      ?.copyWith(fontSize: 16.sp, color: Colors.white),
                ),
              SizedBox(
                height: 30.h,
              ),
              if (UserController.to.loggedIn.isFalse)
                DrawerItem(
                    label: "Login".tr(),
                    icon: AssetConstant.profile,
                    onTap: () {
                      Get.to(() => LoginScreen());
                    }),
              if (UserController.to.loggedIn.isFalse) const DrawerDivider(),
              DrawerItem(
                  label: "Home".tr(),
                  icon: AssetConstant.home,
                  onTap: () {
                    Get.off(() => const HomeScreen());
                  }),
              const DrawerDivider(),
              DrawerItem(
                  label: "Categories".tr(),
                  icon: AssetConstant.categories,
                  onTap: () {
                    Get.off(() => const CategoryListScreen());
                  }),
              if (UserController.to.loggedIn.isTrue) const DrawerDivider(),
              if (UserController.to.loggedIn.isTrue)
                DrawerItem(
                    label: "Order".tr(),
                    icon: AssetConstant.order,
                    onTap: () {
                      Get.off(() => const OrderHistoryScreen());
                    }),
              if (UserController.to.loggedIn.isTrue) const DrawerDivider(),
              if (UserController.to.loggedIn.isTrue)
                DrawerItem(
                    label: "Profile".tr(),
                    icon: AssetConstant.profile,
                    onTap: () {
                      Get.off(() => const ProfileScreen());
                    }),
              const DrawerDivider(),
              DrawerItem(
                  label: "Offers".tr(),
                  icon: AssetConstant.offer,
                  onTap: () {
                    Get.off(() => const OfferProductListScreen());
                  }),
              if (UserController.to.loggedIn.isTrue) const DrawerDivider(),
              if (UserController.to.loggedIn.isTrue)
                DrawerItem(
                    label: "Contact Information".tr(),
                    icon: AssetConstant.contact,
                    onTap: () {
                      Get.off(() => const ContactScreen());
                    }),
              if (UserController.to.loggedIn.isTrue) const DrawerDivider(),
              if (UserController.to.loggedIn.isTrue)
                DrawerItem(
                    label: "Sign out".tr(),
                    icon: AssetConstant.logout,
                    onTap: () {
                      UserController.to.logoutDialog();
                    }),
              const Spacer(),
              GestureDetector(
                onTap: () => Helper.showLanguageSelector(),
                child: Text(
                  "Change Language".tr(),
                  style: Get.textTheme.bodyText2
                      ?.copyWith(color: Colors.white, fontSize: 13.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
