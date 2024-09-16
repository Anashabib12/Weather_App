import 'package:get/get.dart';

class LocationViewModel extends GetxController {
  List<String> filteredLocationsList = <String>[].obs;
  List<String> allLocationsList = [
    'Rawalpindi, Pakistan',
    'Islamabad, Pakistan',
    'Lahore, Pakistan',
    'Karachi, Pakistan',
    'Multan, Pakistan',
    'Faisalabad, Pakistan',
    'Quetta, Pakistan',
    'Peshawar, Pakistan',
    'Gujranwala, Pakistan',
    'Hyderabad, Pakistan',
  ];
  @override
  void onReady() {
    // TODO: implement onReady
    filteredLocationsList.addAll(allLocationsList);
    super.onReady();
  }

  onSearchLocation(String value) {
    filteredLocationsList.clear();
    filteredLocationsList.addAll(allLocationsList
        .where((e) => e.toLowerCase().contains(value.toLowerCase())));
  }

  onLocationSelection (int index) {
    Get.back(result: filteredLocationsList[index]);
  }
}
