import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Trans;
import 'package:place_picker/place_picker.dart';
import 'package:rodenberg/screens/others/no_location_screen.dart';

class LocationHelper {
  static LatLng currentLocation = const LatLng(28.6362436, 77.1883703);
  static String currentCity = "Bengaluru";

  static Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.to(() => const NoLocationScreen());
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.to(() => const NoLocationScreen());
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.to(() => const NoLocationScreen());
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    try {
      var pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(pos.longitude);
      print(pos.latitude);
      currentLocation = LatLng(pos.latitude, pos.longitude);
      await decodeAddressFromLatLng(pos.latitude, pos.longitude);
    } catch (e) {
      print(e);
      var pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(pos.longitude);
      print(pos.latitude);
      currentLocation = LatLng(pos.latitude, pos.longitude);
      await decodeAddressFromLatLng(pos.latitude, pos.longitude);
    }
    return;
  }

  static Future<void> decodeAddressFromLatLng(double lat, double lng) async {
    List<Placemark> address = await placemarkFromCoordinates(lat, lng);

    // var address = await Geocoder.google(AppConstant.MAP_API_KEY).findAddressesFromCoordinates(Coordinates(lat, lng));
    // var geo = GeoCode(apiKey: AppConstant.MAP_API_KEY);
    // var address = await geo.reverseGeocoding(latitude: lat, longitude: lng);
    var first = address.first;
    print(first.subLocality);
    print(first.locality);
    print(first.administrativeArea);
    currentCity = first.subAdministrativeArea ?? "Unknown";
    print("LOCATION:${first.locality}");
    print("LOCATION:${first.subLocality}");
  }
}
