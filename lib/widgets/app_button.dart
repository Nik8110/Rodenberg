import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/utils/app_colors.dart';

class AppButton extends StatefulWidget {
  final String label;
  final  Future<void> Function()? onTap;
  const AppButton({Key? key, required this.label, this.onTap}) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: ()async{
        if(loading||widget.onTap==null) return;
        setState(() {
          loading = true;
        });
        await widget.onTap!();
        setState(() {
          loading = false;
        });
      },
      child: AnimatedContainer(
        duration: 300.milliseconds,
        padding: loading?const EdgeInsets.all(10): const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: loading?
        SizedBox(
            height: 20.h,
            width: 20.h,
            child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation(AppColors.white),strokeWidth: 2,)):
        SizedBox(
          height: 20.h,
          child: Text(widget.label,style: Get.textTheme.bodyText1?.copyWith(
            color: AppColors.white,
          ),),
        )),
    );
  }
}
