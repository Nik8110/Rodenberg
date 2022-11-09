import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/order_controller.dart';
import 'package:rodenberg/controller/user_controller.dart';
import 'package:rodenberg/modals/order_history.dart';
import 'package:rodenberg/modals/order_item.dart';
import 'package:rodenberg/screens/home_screen.dart';
import 'package:rodenberg/screens/order/delivery_slot_screens.dart';
import 'package:rodenberg/services/api_service/api_service.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/widgets/app_bar_widget.dart';
import 'package:rodenberg/widgets/app_button.dart';
import 'package:rodenberg/widgets/drawer_widget.dart';
import 'package:rodenberg/widgets/input_widget.dart';


class OrderDetailScreen extends StatefulWidget {
  final OrderHistoryModel orderHistory;
  const OrderDetailScreen({Key? key, required this.orderHistory}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

  List<OrderItemModel> orderItems = [];
  bool loading = true;


  @override
  void initState() {
    super.initState();
    APIService.instance.getOrderItems({"order_id":widget.orderHistory.orderId,"token":UserController.to.token}).then((value) => {
      setState((){
        orderItems = value.data!;
        loading =false;
    })
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.backGroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h,),
                  GestureDetector(
                    onTap: ()=>Get.back(),
                    child: Row(
                      children: [
                        SizedBox(width: 10.w,),
                        const Icon(Icons.chevron_left,color: Colors.black54,),
                        Text("Back".tr(),style: Get.textTheme.bodyText2?.copyWith(color: Colors.black54),)
                      ],
                    ),
                  ),
                  const Divider(thickness: 0.5,color: Colors.black87,),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text("Order Details".tr(),style: Get.textTheme.bodyText2?.copyWith(color: Colors.black),),
                  ),
                  SizedBox(height: 5.h,),
                ],
              ),
            ),

            SizedBox(height: 10.h,),
            loading?Center(child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            )):Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Items ()".tr(args: ["${orderItems.length}"])),
                  SizedBox(height: 20.h,),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return ItemCard(item: orderItems[index]);
                  }, separatorBuilder: (context,index){
                        return const Divider(color: Colors.grey,);
                  }, itemCount: orderItems.length)
                ],
              ),
            )
            
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final OrderItemModel item;
  const ItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Row(

          children: [

            Container(
              height: 50.h,
              width: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(item.productImage!),
                  fit: BoxFit.cover,
                )
              ),
            ),
            SizedBox(width: 20.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.productName!,
                  maxLines: 1,
                  style:Get.textTheme.bodyText2!.copyWith(
                      fontSize: 15.sp
                  ),),
                Text("\$ ${item.totalPrice!}",
                  maxLines: 1,
                  style:Get.textTheme.bodyText2!.copyWith(
                      fontSize: 15.sp,
                    color: AppColors.primaryColor
                  ),)

              ],
            ),

          ],

        ),
        Text("Qty".tr(args: ["${item.quantity}"]),style: Get.textTheme.bodyText2!.copyWith(
          color: Colors.grey.shade500,
          fontSize: 12.sp
        ),)
      ],
    );
  }
}



