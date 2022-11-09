import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:rodenberg/controller/user_controller.dart';
import 'package:rodenberg/screens/home_screen.dart';
import 'package:rodenberg/services/api_service/urls.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/asset_constant.dart';
import 'package:rodenberg/screens/add_new_address_screen.dart';
import 'package:rodenberg/utils/helper.dart';
import 'package:rodenberg/widgets/app_bar_widget.dart';
import 'package:rodenberg/widgets/app_button.dart';
import 'package:rodenberg/widgets/drawer_widget.dart';
import 'package:rodenberg/widgets/input_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  XFile? selectedImage;

  @override
  void initState() {
    super.initState();
    nameController.text = UserController.to.authUser.value!.name!;
    locationController.text =
        UserController.to.authUser.value!.deliveryAddress!;
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
            SizedBox(
              height: 5.h,
            ),
            GestureDetector(
              onTap: () => Get.off(() => const HomeScreen()),
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
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      color: AppColors.backGroundColor,
                      width: double.infinity,
                      height: 70.h,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 70.h,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: ()async{
                    final ImagePicker _picker = ImagePicker();
                    selectedImage = await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {

                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 100.h,
                      width: 100.h,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                              image: (selectedImage != null)?FileImage(File(selectedImage!.path)):((UserController.to.authUser.value!.image==null)
                                  ? const AssetImage(AssetConstant.avatar)
                                  : NetworkImage(URLS.IMAGE_BASE_URL+UserController.to.authUser.value!.image!) as ImageProvider)
                          )
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    InputWidget(
                        label: "Name".tr(), controller: nameController),
                    SizedBox(
                      height: 10.h,
                    ),
                    InputWidget(
                      label: "Location".tr(),
                      controller: locationController,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AppButton(label: "Save".tr(),onTap: ()async{

                      if(nameController.text.isEmpty) return Helper.showSnackbar("Error".tr(), "Enter valid name".tr());
                      if(locationController.text.isEmpty) return Helper.showSnackbar("Error".tr(), "Location is required".tr());
                      Map<String, dynamic> data = {};
                      data["name"] = nameController.text;
                      data["delivery_address"] = locationController.text;
                      if(selectedImage!=null){
                        data["image"] = await MultipartFile.fromFile(selectedImage!.path, filename: selectedImage!.name);
                      }
                      await UserController.to.updateProfile(data);
                      Get.back();
                    },),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
