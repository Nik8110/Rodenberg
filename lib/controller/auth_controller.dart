import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/user_controller.dart';
import 'package:rodenberg/screens/home_screen.dart';
import 'package:rodenberg/screens/login_screen.dart';
import 'package:rodenberg/services/api_service/api_service.dart';
import 'package:rodenberg/utils/helper.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  signup(String name, String email, String password, String confirmPassword,
      String phone) async {
    var data = {
      "name": name,
      "email": email,
      "password": password,
      "confirm_password": confirmPassword,
      "contact": phone
    };

    var res = await APIService.instance.signup(data);
    if (res.status == 200) {
      Helper.showSnackbar(
          "Sign up successfully".tr(), "You can login now".tr());
      Future.delayed(1.seconds, () => Get.offAll(() => LoginScreen()));
    } else {
      Helper.showSnackbar("Error".tr(), res.msg);
    }
  }

  login(String emailOrPhone, String password) async {
    var data = {"email": emailOrPhone, "password": password, "device_id": ""};

    var res = await APIService.instance.login(data);
    if (res.status) {
      UserController.to.signIn(res.data!, res.token);
      Future.delayed(1.seconds, () => Get.offAll(() => const HomeScreen()));
    } else {
      Helper.showSnackbar("Error".tr(), res.msg);
    }
  }

  resetPassword(String email) async {
    var data = {"email": email};
    var res = await APIService.instance.forgotPassword(data);
    if (res.status) {
      Helper.showSnackbar("", "Mail sent successfully".tr());
    } else {
      Helper.showSnackbar("Error".tr(), res.msg);
    }
  }
}
