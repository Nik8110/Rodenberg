import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/modals/product.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/widgets/cart_button.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(product.image!))),
          ),
          const SizedBox(
            height: 5,
          ),
          Flexible(
              child: Text(
            "${product.name}",
            style: Get.textTheme.bodyText2?.copyWith(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\$ ${product.discountPrice}",
                style: Get.textTheme.bodyText2
                    ?.copyWith(color: AppColors.primaryColor),
              ),
              if (product.discountPercent! != "0")
                SizedBox(
                  width: 8.w,
                ),
              if (product.discountPercent! != "0")
                Text(
                  "\$ ${product.price}",
                  style: Get.textTheme.bodyText2?.copyWith(
                      color: AppColors.secondaryColor,
                      fontSize: 12.sp,
                      decoration: TextDecoration.lineThrough),
                ),
            ],
          ),
          CartButton(
            product: product,
          )
        ],
      ),
    );
  }
}

class ProductLandscapeWidget extends StatelessWidget {
  final Product product;
  const ProductLandscapeWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100.h,
            width: 100.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(product.image!))),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product.name}",
                  style: Get.textTheme.bodyText2?.copyWith(),
                ),
                Row(
                  children: [
                    Text(
                      "\$ ${product.discountPrice}",
                      style: Get.textTheme.bodyText2
                          ?.copyWith(color: AppColors.primaryColor),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    if (product.discountPercent! != "0")
                      Text(
                        "\$ ${product.price}",
                        style: Get.textTheme.bodyText2?.copyWith(
                            color: AppColors.secondaryColor,
                            fontSize: 12.sp,
                            decoration: TextDecoration.lineThrough),
                      ),
                    SizedBox(
                      width: 8.w,
                    ),
                    if (product.discountPercent! != "0")
                      Text(
                          "{}% SAVE".tr(args: [product.discountPercent ?? "0"]),
                          style: Get.textTheme.bodyText2?.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: 12.sp,
                          )),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CartButton(
                      product: product,
                    ),
                  ],
                )
              ],
            ),
          ),
          // const Spacer(),
          // SizedBox(
          //   width: 150.w,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       const Spacer(),
          //       CartButton(
          //         product: product,
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
