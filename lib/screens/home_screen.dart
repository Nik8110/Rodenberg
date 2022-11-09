import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/home_controller.dart';
import 'package:rodenberg/modals/category.dart';
import 'package:rodenberg/modals/offer.dart';
import 'package:rodenberg/screens/category_product_list_screen.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/widgets/app_bar_widget.dart';
import 'package:rodenberg/widgets/custom_image.dart';
import 'package:rodenberg/widgets/drawer_widget.dart';
import 'package:rodenberg/widgets/product_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(1.seconds, () => Get.put(HomeController()).fetchHome());
  }

  final FlutterShareMe flutterShareMe = FlutterShareMe();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        drawer: const CustomDrawer(),
        appBar: const CustomAppBar(),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              flutterShareMe.shareWhatsAppPersonalMessage(
                  message: ' ', phoneNumber: '+4915224528424');
            },
            child: Image.asset('assets/images/WhatsApp.png', fit: BoxFit.cover),
            mini: true),
        body: SafeArea(
            bottom: false,
            child: HomeController.to.loading.value
                ? Center(
                    child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                  ))
                : Column(
                    children: [
                      // SizedBox(height: 20.h,),
                      SizedBox(
                        width: Get.width,
                        height: 120.h,
                        child: Center(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: HomeController.to.categoryList.length,
                              // separatorBuilder: (context, index){
                              //   return SizedBox(width: 20.w,);
                              // },
                              itemBuilder: (context, index) {
                                var category =
                                    HomeController.to.categoryList[index];
                                return CategoryCard(
                                  category: category,
                                );
                              }),
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: const [
                      //     CategoryCard(icon: AssetConstant.milk, label: "Milk"),
                      //     CategoryCard(icon: AssetConstant.iceCream, label: "Ice Cream"),
                      //     CategoryCard(icon: AssetConstant.butter, label: "Butter"),
                      //     CategoryCard(icon: AssetConstant.cheese, label: "Cheese")
                      //   ],
                      // ),
                      // SizedBox(height: 20.h,),
                      Expanded(
                        child: Container(
                          color: AppColors.backGroundColor,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                if (HomeController.to.offerList.length
                                    .isGreaterThan(0))
                                  SizedBox(
                                    width: Get.width,
                                    height: 150.h,
                                    child: Swiper(
                                      loop: false,
                                      autoplay: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return OfferWidget(
                                            offer: HomeController
                                                .to.offerList[index]);
                                      },
                                      itemCount:
                                          HomeController.to.offerList.length,
                                      viewportFraction: 1,
                                      scale: 1,
                                    ),
                                  ),
                                //Image.asset(AssetConstant.banner1,width: double.infinity,height:150.h,fit: BoxFit.cover,),
                                GridView.count(
                                  childAspectRatio: 3 / 4,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 20),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 25,
                                  mainAxisSpacing: 20,
                                  children: [
                                    ...HomeController.to.productList
                                        .map((element) =>
                                            ProductWidget(product: element))
                                        .toList()
                                  ],
                                ),
                                //Image.asset(AssetConstant.banner2,width: double.infinity,height:150.h,fit: BoxFit.cover,),
                                // GridView.count(
                                //   childAspectRatio: 3/4,
                                //   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                                //   shrinkWrap: true,
                                //   physics: const NeverScrollableScrollPhysics(),
                                //   crossAxisCount: 2,
                                //   crossAxisSpacing: 25,
                                //   mainAxisSpacing: 20,
                                //   children: const [
                                //     // ProductWidget(),
                                //     // ProductWidget(),
                                //     // ProductWidget(),
                                //     // ProductWidget(),
                                //   ],
                                // ),
                                Text(
                                  "2022 ALL RIGHTS ARE RESERVED".tr(),
                                  style: Get.textTheme.bodyText2
                                      ?.copyWith(fontSize: 12.sp),
                                ),
                                SizedBox(
                                  height:
                                      Get.mediaQuery.viewPadding.bottom + 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
      ),
    );
  }
}

class OfferWidget extends StatelessWidget {
  final Offer offer;
  const OfferWidget({Key? key, required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Image.network(
          offer.image!,
          width: double.infinity,
          height: 150.h,
          fit: BoxFit.cover,
        ));
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () =>
            Get.to(() => CategoryProductListScreen(categoryID: category.id!)),
        child: Column(
          children: [
            CustomImage(height: 60.h, width: 60.h, url: "${category.image}"),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "${category.name}",
              style: Get.textTheme.bodyText2?.copyWith(fontSize: 15.sp),
            )
          ],
        ),
      ),
    );
  }
}
