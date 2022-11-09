import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/modals/product.dart';
import 'package:rodenberg/services/cart_service/cart_service.dart';
import 'package:rodenberg/utils/app_colors.dart';

class CartButton extends StatefulWidget {
  final Product product;
  const CartButton({Key? key, required this.product}) : super(key: key);

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  int quantity = 0;
  TextEditingController quantityCount = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    quantity = CartService.to.getQuantity(widget.product);
    quantityCount.text = quantity.toString();
    if (widget.product.isStock == "Not avaliable") {
      return Text(
        "Out of Stock".tr(),
        textAlign: TextAlign.center,
      );
    }
    return SizedBox(
      height: 33.h,
      child: quantity == 0
          ? GestureDetector(
              onTap: () async {
                CartService.to.increaseQuantity(widget.product);
                quantity = CartService.to.getQuantity(widget.product);

                setState(() {});
              },
              child: AnimatedContainer(
                  duration: 300.milliseconds,
                  padding:
                      EdgeInsets.symmetric(vertical: 7.h, horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    height: 12.h,
                    child: Text(
                      "Add".tr(),
                      style: Get.textTheme.bodyText1
                          ?.copyWith(color: AppColors.white, fontSize: 12.sp),
                    ),
                  )),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    CartService.to.decreaseQuantity(widget.product);
                    quantity = CartService.to.getQuantity(widget.product);
                    setState(() {});
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox(
                        height: 20.h,
                        child: Text(
                          "-",
                          style: Get.textTheme.bodyText1?.copyWith(
                              color: AppColors.white, fontSize: 12.sp),
                        ),
                      )),
                ),
                SizedBox(
                  width: 45.w,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    autofocus: false,
                    maxLength: 3,
                    maxLines: 1,
                    controller: quantityCount,
                    onChanged: (val) {
                      if (val.isEmpty) return;
                      int quant = int.parse(val);
                      CartService.to.setQuantity(widget.product, quant);
                      setState(() {});
                    },
                    onFieldSubmitted: (val) {
                      if (val.isEmpty) return;
                      int quant = int.parse(val);
                      CartService.to.setQuantity(widget.product, quant);
                      setState(() {});
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    cursorColor: AppColors.primaryColor,
                    cursorHeight: 12.h,
                    showCursor: false,
                    decoration: InputDecoration(
                        counter: const SizedBox(),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h)),
                  ),
                ),
                //Text("$quantity"),
                GestureDetector(
                  onTap: () {
                    print('PRODUCT === ${widget.product.discountPrice}');
                    print('PRODUCT === ${widget.product.price}');
                    print('PRODUCT === ${widget.product.discountPercent}');
                    print(
                        'PRODUCT === ${double.parse(widget.product.price!) - widget.product.discountPrice!}');
                    CartService.to.increaseQuantity(widget.product);
                    quantity = CartService.to.getQuantity(widget.product);
                    setState(() {});
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox(
                        height: 20.h,
                        child: Text(
                          "+",
                          style: Get.textTheme.bodyText1?.copyWith(
                              color: AppColors.white, fontSize: 12.sp),
                        ),
                      )),
                ),
              ],
            ),
    );
  }
}
