import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rodenberg/controller/order_controller.dart';
import 'package:rodenberg/controller/user_controller.dart';
import 'package:rodenberg/screens/home_screen.dart';
import 'package:rodenberg/screens/order/delivery_slot_screens.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/helper.dart';
import 'package:rodenberg/widgets/app_bar_widget.dart';
import 'package:rodenberg/widgets/app_button.dart';
import 'package:rodenberg/widgets/drawer_widget.dart';
import 'package:rodenberg/widgets/input_widget.dart';

import '../../utils/uppercase_formatter.dart';


class OrderAddDetailsScreen extends StatefulWidget {
  const OrderAddDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OrderAddDetailsScreen> createState() => _OrderAddDetailsScreenState();
}

class _OrderAddDetailsScreenState extends State<OrderAddDetailsScreen> {

  TextEditingController _phone = TextEditingController();
  TextEditingController _businessName = TextEditingController();
  TextEditingController _rut = TextEditingController();
  TextEditingController _email = TextEditingController();
  @override
  void initState() {
    super.initState();

    if(UserController.to.authUser.value!.businessName!=null)
    _businessName.text = UserController.to.authUser.value!.businessName!;
    if(UserController.to.authUser.value!.rut!=null)
    _rut.text = UserController.to.authUser.value!.rut!;
    if(UserController.to.authUser.value!.email!=null)
      _email.text = UserController.to.authUser.value!.email!;




  }


  @override
  void dispose() {
    super.dispose();
    _phone.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.white,
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
                    child: Text("Add Details".tr(),style: Get.textTheme.bodyText2?.copyWith(color: Colors.black),),
                  ),
                  SizedBox(height: 5.h,),
                ],
              ),
            ),

            SizedBox(height: 10.h,),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [

                  InputWidget(label: "Phone no.".tr(), controller: _phone, inputType: TextInputType.number,inputFormat: [
                    // MaskInputFormatter(mask: '#########')
                    MaskTextInputFormatter(
                        mask: '#########',
                        filter: { "#": RegExp(r'[0-9]') },
                        type: MaskAutoCompletionType.lazy
                    ),
                  ],prefixText: "+56 ",),
                  // SizedBox(height: 10.h,),
                  InputWidget(label: "Business Name".tr(), controller: _businessName),
                  SizedBox(height: 10.h,),
                  InputWidget(label: "RUT".tr(), hint: "(XXXXXXXX-X)", controller: _rut, inputFormat: [
                  // MaskInputFormatter(mask: 'AAAAAAAA-A', textAllCaps: true),
                    UpperCaseTextFormatter(),
                    MaskTextInputFormatter(
                      mask: '########-#',
                      filter: { "#": RegExp(r'[0-9A-Z]') },
                      type: MaskAutoCompletionType.lazy
                  ),
                  ]),
                  SizedBox(height: 10.h,),
                  InputWidget(label: "E-mail".tr(), controller: _email),
                  SizedBox(height: 30.h,),
                  AppButton(label: "Confirm Order".tr(),onTap: ()async{
                    if(_phone.text.isEmpty || _phone.text.length!=9){
                      return Helper.showSnackbar("Error".tr(), "Valid Phone is required".tr());
                    }
                    if(_businessName.text.isEmpty) {
                      return Helper.showSnackbar("Error".tr(), "Business Name is required".tr());
                    }
                    if(_email.text.isEmpty){
                      return Helper.showSnackbar("Error".tr(), "Enter valid email".tr());
                    }
                    if(_rut.text.isEmpty || _rut.text.length != 10) {
                      return Helper.showSnackbar("Error".tr(), "Valid RUT is required".tr());
                    }


                    OrderController.to.phone = "+56 "+_phone.text;
                    OrderController.to.email = _email.text;
                    OrderController.to.businessName = _businessName.text;
                    OrderController.to.rut = _rut.text;

                      var res = await UserController.to.updateProfile({
                        "business_name":_businessName.text,
                        "rut":_rut.text
                      });
                    if(!res.status) return Helper.showSnackbar("Error".tr(), res.msg);

                    await OrderController.to.getDeliverySlots();
                      Get.to(()=>const DeliverySlotsScreen());
                  },)
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}




