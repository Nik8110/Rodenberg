import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/helper/location_helper.dart';
import 'package:rodenberg/modals/category.dart';
import 'package:rodenberg/modals/offer.dart';
import 'package:rodenberg/modals/product.dart';
import 'package:rodenberg/services/api_service/api_service.dart';

import '../screens/others/service_not_available.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxBool loading = false.obs;

  RxList<Category> categoryList = (<Category>[]).obs;
  RxList<Product> productList = (<Product>[]).obs;
  RxList<Offer> offerList = (<Offer>[]).obs;

  @override
  void onInit() {
    // fetchCategory();
    // fetchHomeProducts();
  }

  fetchHome() async {
    loading.value = true;
    await fetchCategory();
    await fetchHomeProducts();
    await fetchOffer();
    loading.value = false;
  }

  fetchCategory() async {
    var ls = await APIService.instance.getCategoryList();
    categoryList.value = ls.data!;
  }

  fetchHomeProducts() async {
    var ls = await APIService.instance.getHomeProductList({
      "location": LocationHelper.currentCity,
      "latitude": LocationHelper.currentLocation.latitude.toString(),
      "longitude": LocationHelper.currentLocation.longitude.toString()
    });

/* print('CURRENT CITY === ${{
      "location": LocationHelper.currentCity,
      "latitude": LocationHelper.currentLocation.latitude,
      "longitude": LocationHelper.currentLocation.longitude
    }}');*/

    productList.value = ls.data!;
    if (ls.data!.isEmpty) {
      Get.off(() => const ServiceNotAvailable());
    }
  }

  fetchOffer() async {
    var ls = await APIService.instance.getOfferList({
      "location": LocationHelper.currentCity,
      "latitude": LocationHelper.currentLocation.latitude.toString(),
      "longitude": LocationHelper.currentLocation.longitude.toString()
    });
    offerList.value = ls.data!;
  }
}
