import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/user_controller.dart';
import 'package:rodenberg/helper/location_helper.dart';
import 'package:rodenberg/modals/product.dart';
import 'package:rodenberg/services/api_service/api_service.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/helper.dart';
import 'package:rodenberg/widgets/app_bar_widget.dart';
import 'package:rodenberg/widgets/drawer_widget.dart';
import 'package:rodenberg/widgets/product_widget.dart';

class CategoryProductListScreen extends StatefulWidget {
  final String categoryID;
  const CategoryProductListScreen({Key? key, required this.categoryID})
      : super(key: key);

  @override
  State<CategoryProductListScreen> createState() =>
      _CategoryProductListScreenState();
}

class _CategoryProductListScreenState extends State<CategoryProductListScreen> {
  List<Product> productList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    var res = await APIService.instance.getCategoryProductList({
      "category_id": widget.categoryID,
      "location": LocationHelper.currentCity,
      "latitude": LocationHelper.currentLocation.latitude.toString(),
      "longitude": LocationHelper.currentLocation.longitude.toString(),
      "token": UserController.to.token
    });
    if (res.status) {
      setState(() {
        productList = res.data!;
        loading = false;
      });
    } else {
      Helper.showSnackbar("Error".tr(), res.msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: (loading)
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
              ),
            )
          : SingleChildScrollView(
              child: Column(
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
                        )
                      ],
                    ),
                  ),
                  if (productList.length.isGreaterThan(0))
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          return ProductLandscapeWidget(
                            product: productList[index],
                          );
                        }),
                  if (productList.length.isEqual(0))
                    Center(
                      child: Text("No Product found".tr()),
                    )
                ],
              ),
            ),
    );
  }
}
