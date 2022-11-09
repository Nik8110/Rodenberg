import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/user_controller.dart';
import 'package:rodenberg/modals/order_history.dart';
import 'package:rodenberg/screens/order/order_detail_screen.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/widgets/app_bar_widget.dart';
import 'package:rodenberg/widgets/app_button.dart';
import 'package:rodenberg/widgets/drawer_widget.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  bool recOrderLoading = true;
  bool penOrderLoading = true;
  List<OrderHistoryModel> recOrders = [];
  List<OrderHistoryModel> penOrders = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        drawer: const CustomDrawer(),
        appBar: const CustomAppBar(),
        body: SizedBox(
          width: Get.width,
          height: Get.height - Get.statusBarHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                //height: 50.h,
                child: Material(
                  color: Colors.grey.withOpacity(0.3),
                  child: TabBar(
                    automaticIndicatorColorAdjustment: true,
                    //unselectedLabelColor: AppColors.black,

                    indicator: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: AppColors.secondaryColor, width: 2)),
                        color: AppColors.white),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColors.black,
                    indicatorColor: AppColors.secondaryColor,
                    tabs: [
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Received Orders".tr()),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Pending Orders".tr()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  recOrderLoading
                      ? Center(
                          child: SizedBox(
                              width: 40.w,
                              height: 40.w,
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              )),
                        )
                      : (recOrders.isNotEmpty
                          ? ListView.builder(
                              itemCount: recOrders.length,
                              itemBuilder: (context, index) {
                                return OrderHistoryCard(
                                    orderHistory: recOrders[index]);
                              })
                          : Center(child: Text("No order found".tr()))),
                  penOrderLoading
                      ? Center(
                          child: SizedBox(
                              width: 40.w,
                              height: 40.w,
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              )),
                        )
                      : (penOrders.isNotEmpty
                          ? ListView.builder(
                              itemCount: penOrders.length,
                              itemBuilder: (context, index) {
                                return OrderHistoryCard(
                                  orderHistory: penOrders[index],
                                  delivered: false,
                                );
                              })
                          : Center(child: Text("No order found".tr()))),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getPenOrders();
    getRecOrders();
  }

  getRecOrders() async {
    recOrders = await UserController.to.getReceivedOrderHistory();
    setState(() {
      recOrderLoading = false;
    });
  }

  getPenOrders() async {
    penOrders = await UserController.to.getPendingOrderHistory();
    setState(() {
      penOrderLoading = false;
    });
  }
}

class OrderHistoryCard extends StatelessWidget {
  final OrderHistoryModel orderHistory;
  final bool delivered;
  const OrderHistoryCard(
      {Key? key, required this.orderHistory, this.delivered = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                "Order Id".tr(),
                style: Get.textTheme.bodyText2!.copyWith(),
              )),
              Expanded(
                  child: Text(
                "${orderHistory.orderId}",
                style: Get.textTheme.bodyText2!.copyWith(),
              )),
            ],
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5),
            thickness: 1,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                "Order Date".tr(),
                style: Get.textTheme.bodyText2!.copyWith(),
              )),
              Expanded(
                  child: Text(
                "${orderHistory.orderDate}",
                style: Get.textTheme.bodyText2!.copyWith(),
              )),
            ],
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5),
            thickness: 1,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                delivered ? "Delivery Date".tr() : "Expected Date".tr(),
                style: Get.textTheme.bodyText2!.copyWith(),
              )),
              Expanded(
                  child: Text(
                "${orderHistory.deliveryDate}",
                style: Get.textTheme.bodyText2!.copyWith(),
              )),
            ],
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5),
            thickness: 1,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                "Total Items".tr(),
                style: Get.textTheme.bodyText2!.copyWith(),
              )),
              Expanded(
                  child: Text(
                "${orderHistory.totalItem}",
                style: Get.textTheme.bodyText2!.copyWith(),
              )),
            ],
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5),
            thickness: 1,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                "Order Amount".tr(),
                style: Get.textTheme.bodyText2!.copyWith(),
              )),
              Expanded(
                  child: Text(
                "\$${orderHistory.orderAmount}",
                style: Get.textTheme.bodyText2!.copyWith(),
              )),
            ],
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5),
            thickness: 1,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                "VAT".tr(),
                style: Get.textTheme.bodyText2!.copyWith(),
              )),
              Expanded(
                  child: Text(
                "\$${(orderHistory.orderAmount! - (orderHistory.orderAmount! * 100 / (100 + orderHistory.taxRate!))).toPrecision(2)}",
                style: Get.textTheme.bodyText2!.copyWith(),
              )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Transform.scale(
              scale: 0.65,
              child: AppButton(
                label: "View Details".tr(),
                onTap: () async {
                  Get.to(() => OrderDetailScreen(orderHistory: orderHistory));
                },
              )),
          if (delivered)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "feedback".tr(),
                  style: Get.textTheme.bodyText2!
                      .copyWith(color: Colors.grey, fontSize: 12.sp),
                ),
              ],
            )
        ],
      ),
    );
  }
}
