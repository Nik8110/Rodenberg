import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart';
import 'package:rodenberg/modals/order_history.dart';
import 'package:rodenberg/modals/user.dart';
import 'package:rodenberg/screens/home_screen.dart';
import 'package:rodenberg/services/api_service/api_service.dart';
import 'package:rodenberg/services/api_service/base_response.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/helper.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  RxBool loggedIn = false.obs;
  Rx<User?> authUser = Rx(null);
  String token = "";
  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    if (_storage.read("token") != null) {
      token = _storage.read("token");
      loggedIn.value = true;
      authUser.value =
          User.fromJson(_storage.read("user") as Map<String, dynamic>);
      getProfile();
    }
  }

  signIn(User user, String token) {
    authUser.value = user;
    loggedIn.value = true;
    this.token = token;
    _storage.write("user", user.toJson());
    _storage.write("token", token);
    getProfile();
  }

  logoutDialog() {
    return Get.dialog(AlertDialog(
      title: Text(
        'Logout'.tr(),
        style: TextStyle(color: AppColors.primaryColor),
      ),
      content: Text('Do you want to logout?'.tr()),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            'NO'.tr(),
            style: TextStyle(color: AppColors.secondaryColor),
          ),
        ),
        TextButton(
          onPressed: () async {
            await UserController.to.logout();
            Get.offAll(() => const HomeScreen());
          },
          child: Text(
            'YES'.tr(),
            style: TextStyle(color: AppColors.secondaryColor),
          ),
        ),
      ],
    ));
  }

  logout() {
    authUser.value = null;
    token = "";
    loggedIn.value = false;
    _storage.erase();
  }

  getProfile() async {
    var res = await APIService.instance.getProfile({"token": token});
    if (res.status) {
      authUser.value = res.data!;
      _storage.write("user", res.data!.toJson());
    } else {
      logout();
      Helper.showSnackbar("Session Expired".tr(), "");
      Get.offAll(() => const HomeScreen());
    }
  }

  updateAddress(data) async {
    data["token"] = token;
    var res = await APIService.instance.updateAddress(data);

    if (res.status) {
      var res = await APIService.instance.updateDeliveryAddress(
          {"token": token, "delivery_address": data["address"]});
      if (!res.status) return Helper.showSnackbar("Error".tr(), res.msg);
      await getProfile();
      Get.back(result: "success");
      Helper.showSnackbar("Success".tr(), res.msg);
    } else {
      Helper.showSnackbar("Error".tr(), res.msg);
    }
  }

  Future<BaseResponse<dynamic>> updateProfile(Map<String, dynamic> data) async {
    data["token"] = token;
    var res = await APIService.instance.updateProfile(data);
    await getProfile();
    return res;
  }

  Future<List<OrderHistoryModel>> getReceivedOrderHistory() async {
    print('TOKEN ==== $token');
    var res = await APIService.instance
        .getOrderHistory({"token": token, "status": "completed"});
    return res.data!.reversed.toList();
  }

  Future<List<OrderHistoryModel>> getPendingOrderHistory() async {
    var res = await APIService.instance
        .getOrderHistory({"token": token, "status": "pending"});
    return res.data!.reversed.toList();
  }
}
