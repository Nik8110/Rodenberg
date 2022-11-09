import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/utils/app_colors.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final Widget suffix;
  final bool isPassword;
  final bool disabled;
  final TextInputType inputType;
  final String prefixText;
  final List<TextInputFormatter> inputFormat;
  const InputWidget({Key? key, required this.label, required this.controller, this.suffix = const SizedBox(), this.isPassword = false,this.disabled=false, this.hint = "", this.inputType=TextInputType.text, this.inputFormat=const [], this.prefixText = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label,style: Get.textTheme.bodyText2?.copyWith(color: AppColors.primaryColor),),
            SizedBox(width:5.w,),
            Text(hint,style: Get.textTheme.bodyText2?.copyWith(color: AppColors.black.withOpacity(0.5),fontSize: 12.sp)),
          ],
        ),
        SizedBox(height: 2.h,),
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: disabled?Colors.grey.withOpacity(0.2):Colors.transparent,
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: TextFormField(
              enabled: !disabled,
              controller: controller,
              cursorColor: AppColors.primaryColor,
              keyboardType: inputType,
              obscureText: isPassword,
              inputFormatters: inputFormat,

              decoration:  InputDecoration(
                prefixText: prefixText,

                contentPadding: const EdgeInsets.only(bottom: 10,left: 5,right: 5),
                border: InputBorder.none
              ),
            ),
          ),
        ),
        SizedBox(height: 5.h,),
        suffix
      ],
    );
  }
}
