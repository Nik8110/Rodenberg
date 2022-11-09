import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart' hide Trans;
import 'package:place_picker/place_picker.dart';
import 'package:rodenberg/controller/user_controller.dart';
import 'package:rodenberg/helper/location_helper.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/app_constant.dart';
import 'package:rodenberg/utils/helper.dart';
import 'package:rodenberg/widgets/app_button.dart';
import 'package:rodenberg/widgets/input_widget.dart';

import '../widgets/app_bar_widget.dart';
import '../widgets/drawer_widget.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final TextEditingController _addressLine = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _state = TextEditingController();
  // final TextEditingController _region =  TextEditingController();
  final TextEditingController _references = TextEditingController();
  final TextEditingController _latitude = TextEditingController();
  final TextEditingController _longitude = TextEditingController();

  LatLng latLng = LatLng(LocationHelper.currentLocation.latitude,
      LocationHelper.currentLocation.longitude);

  @override
  void initState() {
    super.initState();
    // placemarkFromCoordinates(LocationHelper.currentLocation.latitude, LocationHelper.currentLocation.longitude).then((value) {
    //   if(value.isNotEmpty){
    //     var place  = value[0];
    //     _addressLine.text = place.name!;
    //     _city.text = place.subAdministrativeArea!;
    //     _country.text = place.country!;
    //     _state.text = place.administrativeArea!;
    //     _region.text = place.subLocality!;
    //     _references.text = "";
    //     _latitude.text = LocationHelper.currentLocation.latitude.toString();
    //     _longitude.text = LocationHelper.currentLocation.longitude.toString();
    //
    //   }
    // });
    // return;
    if (UserController.to.authUser.value!.address != null) {
      _addressLine.text = UserController.to.authUser.value!.address!;
      _city.text = UserController.to.authUser.value!.city!;
      _country.text = UserController.to.authUser.value!.country!;
      _state.text = UserController.to.authUser.value!.state!;
      // _region.text = UserController.to.authUser.value!.region!;
      _references.text = UserController.to.authUser.value!.reference!;
      _latitude.text = UserController.to.authUser.value!.latitude!;
      _longitude.text = UserController.to.authUser.value!.longitude!;
      if (UserController.to.authUser.value!.latitude!.isEmpty &&
          UserController.to.authUser.value!.longitude!.isEmpty) {
        print(UserController.to.authUser.value!.latitude!);
        print(UserController.to.authUser.value!.longitude!);
        var lat = latLng.latitude;
        var long = latLng.longitude;
        setState(() {
          latLng = LatLng(lat, long);
        });
      }
    } else {
      placemarkFromCoordinates(LocationHelper.currentLocation.latitude,
              LocationHelper.currentLocation.longitude)
          .then((value) {
        if (value.isNotEmpty) {
          var place = value[0];
          _addressLine.text = place.name!;
          _city.text = place.subAdministrativeArea!;
          _country.text = place.country!;
          _state.text = place.administrativeArea!;
          //_region.text = place.subLocality!;
          _references.text = "";
          _latitude.text = LocationHelper.currentLocation.latitude.toString();
          _longitude.text = LocationHelper.currentLocation.longitude.toString();
        }
      });
    }
  }

  loadAddress() {}

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
            GestureDetector(
                onTap: () async {
                  LocationResult result = await Get.to(() => PlacePicker(
                        AppConstant.MAP_API_KEY,
                        displayLocation: latLng,
                      ));

                  if (result == null) return;
                  setState(() {
                    latLng = result.latLng!;
                  });
                  _addressLine.text = result.name!;
                  _city.text = result.city!.name!;
                  _country.text = result.country!.name!;
                  _state.text = result.administrativeAreaLevel1!.name!;
                  // _region.text = result.subLocalityLevel1.name;
                  _latitude.text = result.latLng!.latitude.toString();
                  _longitude.text = result.latLng!.longitude.toString();
                },
                child: Image.network(Helper.getImage(latLng))),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  InputWidget(
                      label: "Address Line".tr(), controller: _addressLine),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: InputWidget(
                              label: "City".tr(), controller: _city)),
                      SizedBox(
                        width: 10.w,
                      ),
                      Flexible(
                          child: InputWidget(
                              label: "Country".tr(), controller: _country)),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: InputWidget(
                              label: "State".tr(), controller: _state)),
                      SizedBox(
                        width: 10.w,
                      ),
                      //Flexible(child: InputWidget(label: "Region".tr(), controller: _region)),
                    ],
                  ),
                  InputWidget(
                      label: "References".tr(),
                      hint: "(Optional)".tr(),
                      controller: _references),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: InputWidget(
                        label: "Latitude".tr(),
                        controller: _latitude,
                        disabled: true,
                      )),
                      SizedBox(
                        width: 10.w,
                      ),
                      Flexible(
                          child: InputWidget(
                        label: "Longitude".tr(),
                        controller: _longitude,
                        disabled: true,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  AppButton(
                    label: "Save Address".tr(),
                    onTap: () async => await validateAddress(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  validateAddress() async {
    if (_addressLine.text.isEmpty)
      return Helper.showSnackbar("Error".tr(), "Address line is required".tr());
    if (_city.text.isEmpty)
      return Helper.showSnackbar("Error".tr(), "City is required".tr());
    if (_country.text.isEmpty)
      return Helper.showSnackbar("Error".tr(), "Country is required".tr());
    if (_state.text.isEmpty)
      return Helper.showSnackbar("Error".tr(), "State is required".tr());
    //if(_region.text.isEmpty) return Helper.showSnackbar("Error", "Region is required");
    // if(_references.text.isEmpty) return Helper.showSnackbar("Error", "References is required");
    if (_latitude.text.isEmpty || _longitude.text.isEmpty)
      return Helper.showSnackbar(
          "Error".tr(), "Location on map is required".tr());
    var data = {
      "token": UserController.to.token,
      "address": _addressLine.text,
      "city": _city.text,
      "state": _state.text,
      "country": _country.text,
      "region": "",
      "references": _references.text,
      "lat": _latitude.text,
      "long": _longitude.text
    };

    await UserController.to.updateAddress(data);
  }
}
