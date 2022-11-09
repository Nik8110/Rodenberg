import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/home_controller.dart';
import 'package:rodenberg/modals/category.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/asset_constant.dart';
import 'package:rodenberg/widgets/app_bar_widget.dart';
import 'package:rodenberg/widgets/custom_image.dart';
import 'package:rodenberg/widgets/drawer_widget.dart';

import 'category_product_list_screen.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: (HomeController.to.categoryList.length.isGreaterThan(0))?GridView.count(
          childAspectRatio: 1,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 25,
          mainAxisSpacing: 20,
          children:  [
            ...HomeController.to.categoryList.map((element) => CategoryCard(category: element,

            )).toList(),
            // CategoryCard(icon: AssetConstant.milk, label: "Milk"),
            // CategoryCard(icon: AssetConstant.iceCream, label: "Ice Cream"),
            // CategoryCard(icon: AssetConstant.butter, label: "Butter"),
            // CategoryCard(icon: AssetConstant.cheese, label: "Cheese")
          ],
        ): Center(child: Text("No Categories".tr()),),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({Key? key, required this.category,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Get.to(()=>CategoryProductListScreen(categoryID: category.id!)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(url:category.image!, height: 50.h,width: 50.h,),
            SizedBox(height: 10.h,),
            Text(category.name!,style: Get.textTheme.bodyText2?.copyWith(fontSize: 15.sp),)
          ],
        ),
      ),
    );
  }
}
