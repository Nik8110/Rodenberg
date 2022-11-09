import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rodenberg/helper/location_helper.dart';
import 'package:rodenberg/modals/product.dart';
import 'package:rodenberg/services/api_service/api_service.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/helper.dart';
import 'package:rodenberg/widgets/app_bar_widget.dart';
import 'package:rodenberg/widgets/drawer_widget.dart';
import 'package:rodenberg/widgets/product_widget.dart';

class OfferProductListScreen extends StatefulWidget {
  const OfferProductListScreen({Key? key}) : super(key: key);

  @override
  State<OfferProductListScreen> createState() => _OfferProductListScreenState();
}

class _OfferProductListScreenState extends State<OfferProductListScreen> {
  List<Product> productList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    print(
        'lat //// ${LocationHelper.currentLocation.latitude.toString()} ${LocationHelper.currentLocation.longitude.toString()}');
    var res = await APIService.instance.getOfferProductList({
      "location": LocationHelper.currentCity,
      "latitude": LocationHelper.currentLocation.latitude.toString(),
      "longitude": LocationHelper.currentLocation.longitude.toString(),
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
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        print(productList[index].discountPercent);
                        return int.parse(productList[index].discountPercent!) >
                                0
                            ? ProductLandscapeWidget(
                                product: productList[index],
                              )
                            : const SizedBox.shrink();
                      }),
                ],
              ),
            ),
    );
  }
}
