import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart' hide Trans;
import 'package:place_picker/place_picker.dart';
import 'package:rodenberg/controller/order_controller.dart';
import 'package:rodenberg/controller/user_controller.dart';
import 'package:rodenberg/helper/location_helper.dart';
import 'package:rodenberg/screens/order/order_add_details_screen.dart';
import 'package:rodenberg/utils/app_colors.dart';
import 'package:rodenberg/utils/app_constant.dart';
import 'package:rodenberg/utils/helper.dart';
import 'package:rodenberg/widgets/app_bar_widget.dart';
import 'package:rodenberg/widgets/app_button.dart';
import 'package:rodenberg/widgets/drawer_widget.dart';
import 'package:rodenberg/widgets/input_widget.dart';

class OrderNewAddressScreen extends StatefulWidget {
  const OrderNewAddressScreen({Key? key}) : super(key: key);

  @override
  State<OrderNewAddressScreen> createState() => _OrderNewAddressScreenState();
}

class _OrderNewAddressScreenState extends State<OrderNewAddressScreen> {
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

    loadCurrentLocation();
  }

  loadCurrentLocation() {
    if (UserController.to.authUser.value?.latitude != null &&
        UserController.to.authUser.value?.longitude != null) {
      placemarkFromCoordinates(latLng.latitude, latLng.longitude).then((value) {
        if (value.isNotEmpty) {
          var place = value[0];
          _addressLine.text = place.name!;
          _city.text = place.subAdministrativeArea!;
          _country.text = place.country!;
          _state.text = place.administrativeArea!;
          // _region.text = place.subLocality!;
          _references.text = "";
          _latitude.text = UserController.to.authUser.value?.latitude ?? "";
          _longitude.text = UserController.to.authUser.value?.longitude ?? "";
        }
      });
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
          // _region.text = place.subLocality!;
          _references.text = "";
          _latitude.text = LocationHelper.currentLocation.latitude.toString();
          _longitude.text = LocationHelper.currentLocation.longitude.toString();
        }
      });
    }
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
                      // Flexible(child: InputWidget(label: "Region".tr(), controller: _region)),
                    ],
                  ),
                  InputWidget(
                      label: "References".tr(),
                      hint: "(Optional)",
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
    //if(_region.text.isEmpty) return Helper.showSnackbar("Error".tr(), "Region is required".tr());
    //if(_references.text.isEmpty) return Helper.showSnackbar("Error".tr(), "References is required".tr());
    if (_latitude.text.isEmpty || _longitude.text.isEmpty)
      return Helper.showSnackbar(
          "Error".tr(), "Location on map is required".tr());
    // if(_city.text != LocationHelper.currentCity) return Helper.showSnackbar("Error".tr(), "Select delivery location in same city as your current location".tr());

    // var data = {"address":_addressLine.text,"city":_city.text,"state":_state.text,"country":_country.text,"region":_region.text,"references":_references.text,"lat":_latitude.text,"long":_longitude.text};
    // await UserController.to.updateAddress(data);

    OrderController.to.city = _city.text;
    OrderController.to.addressLine = _addressLine.text;
    OrderController.to.country = _country.text;
    OrderController.to.state = _state.text;
    // OrderController.to.region = _region.text;
    OrderController.to.references = _references.text;
    OrderController.to.latitude = _latitude.text;
    OrderController.to.longitude = _longitude.text;

    await Get.dialog(AlertDialog(
      title: Text(
        'Confirmation'.tr(),
        style: TextStyle(color: AppColors.primaryColor),
      ),
      content: Text('Is this your invoicing address?'.tr()),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.to(() => const OrderAddDetailsScreen());
          },
          child: Text(
            'NO'.tr(),
            style: TextStyle(color: AppColors.secondaryColor),
          ),
        ),
        TextButton(
          onPressed: () async {
            Get.back();
            var data = {
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
            Get.to(() => const OrderAddDetailsScreen());
          },
          child: Text(
            'YES'.tr(),
            style: TextStyle(color: AppColors.secondaryColor),
          ),
        ),
      ],
    ));
    //await OrderController.to.getDeliverySlots();
  }
}
