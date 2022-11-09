import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rodenberg/controller/auth_controller.dart';
import 'package:rodenberg/controller/order_controller.dart';
import 'package:rodenberg/controller/user_controller.dart';
import 'package:rodenberg/services/cart_service/cart_service.dart';

import 'screens/splash_screen.dart';
import 'utils/app_colors.dart';

// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  //HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  Get.put(UserController());
  Get.put(AuthController());
  Get.put(CartService());
  Get.put(OrderController());
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('es')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: () {
        return GetMaterialApp(
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          debugShowCheckedModeBanner: false,
          title: 'Rodenberg',
          theme: ThemeData(
            primaryColor: AppColors.primaryColor,
            primaryColorLight: AppColors.primaryColor,
            primaryColorDark: AppColors.primaryColor,
            appBarTheme: AppBarTheme(backgroundColor: AppColors.primaryColor),
            scaffoldBackgroundColor: AppColors.white,
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                .copyWith(
              bodyText1: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              bodyText2: GoogleFonts.poppins(fontWeight: FontWeight.w400),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: AppColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.024,
                ),
              ),
            ),
          ),
          home: const SplashScreen(),
          builder: (context, widget) {
            ScreenUtil.setContext(context);
            return widget!;
          },
        );
      },
    );
  }
}
