import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/asset_constant.dart';

class DrawerItem extends StatelessWidget {
  final String label;
  final String icon;
  final Function() onTap;
  const DrawerItem({Key? key, required this.label, required this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 15.h),
        child: Row(
          children: [
            SizedBox(width: 50.w,),
            Image.asset(icon,color: Colors.white,width: 20.w,),
            SizedBox(width: 15.w,),
            Text(label,style: Get.textTheme.bodyText2?.copyWith(
              color: Colors.white,
              fontSize: 16.sp
            ),)
          ],
        ),
      ),
    );
  }
}

class DrawerDivider extends StatelessWidget {
  const DrawerDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(color: Colors.white,height: 1,thickness: 1.2,);
  }
}


