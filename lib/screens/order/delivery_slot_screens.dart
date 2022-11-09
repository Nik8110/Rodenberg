import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/order_controller.dart';
import 'package:rodenberg/modals/delivery_slot.dart';
import 'package:rodenberg/screens/order/payment_screen.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/helper.dart';
import 'package:rodenberg/widgets/app_bar_widget.dart';
import 'package:rodenberg/widgets/app_button.dart';
import 'package:rodenberg/widgets/drawer_widget.dart';

class DeliverySlotsScreen extends StatefulWidget {
  const DeliverySlotsScreen({Key? key}) : super(key: key);

  @override
  State<DeliverySlotsScreen> createState() => _DeliverySlotsScreenState();
}

class _DeliverySlotsScreenState extends State<DeliverySlotsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: SizedBox(
        width: Get.width,
        height: Get.height - Get.statusBarHeight,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.backGroundColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        const Divider(
                          thickness: 0.5,
                          color: Colors.black87,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            "Delivery Slot".tr(),
                            style: Get.textTheme.bodyText2
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  if (OrderController.to.deliverySlots.length.isEqual(0))
                    Center(
                      child: Text("No delivery slots for your location".tr()),
                    ),
                  if (OrderController.to.deliverySlots.length.isGreaterThan(0))
                    Expanded(
                      child: ListView.builder(
                          itemCount: OrderController.to.deliverySlots.length,
                          itemBuilder: (context, index) {
                            return DeliverySlotCard(
                              deliverySlot:
                                  OrderController.to.deliverySlots[index],
                            );
                          }),
                    ),
                ],
              ),
            ),
            if (OrderController.to.deliverySlots.length.isGreaterThan(0))
              Container(
                padding: const EdgeInsets.only(bottom: 25, left: 20),
                width: double.infinity,
                height: 100.h,
                color: const Color(0xFFE3E3E3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Transform.scale(
                        scale: 0.8,
                        child: AppButton(
                          label: "Make Payment".tr(),
                          onTap: () async {
                            if (OrderController.to.selectedDeliverySlot.value
                                .deliveryDate!.isEmpty) {
                              return Helper.showSnackbar(
                                  "Delivery Slot".tr(),
                                  "Please select your preferred delivery slot"
                                      .tr());
                            }
                            Get.to(() => PaymentScreen());
                          },
                        ))
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

class DeliverySlotCard extends StatelessWidget {
  final DeliverySlotModel deliverySlot;
  const DeliverySlotCard({Key? key, required this.deliverySlot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        OrderController.to.selectedDeliverySlot.value = deliverySlot;
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Obx(
          () => Row(
            children: [
              Radio(
                activeColor: AppColors.primaryColor,
                value: deliverySlot.deliveryDay! +
                    "-" +
                    deliverySlot.deliveryDate!,
                groupValue: OrderController
                        .to.selectedDeliverySlot.value.deliveryDay! +
                    "-" +
                    OrderController.to.selectedDeliverySlot.value.deliveryDate!,
                onChanged: (String? value) {
                  OrderController.to.selectedDeliverySlot.value = deliverySlot;
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${deliverySlot.deliveryDay}, ${deliverySlot.deliveryDate}",
                    style: Get.textTheme.bodyText2!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  // Text("9AM - 11AM",style: Get.textTheme.bodyText2!.copyWith(
                  //     color: Colors.black54,
                  //   fontSize: 13.sp
                  // ),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
