import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/helper/getx_helper.dart';
import 'package:weather_app/helper/global_variables.dart';
import 'package:weather_app/screens/home/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/screens/location/location_view.dart';

class HomeViewModel extends GetxController {
  Rx<WeatherModel> weatherModel = WeatherModel().obs;
  RxString location = 'Islamabad, Pakistan'.obs;

  @override
  void onReady() {
    getLastLocationAndUpdate();
    super.onReady();
  }

  void changeLocation() async {
    var result = await Get.to(() => LocationView());
    if (result != null) {
      location.value = result;
      GetStorage().write('lastLocation', location.value);
      getLastLocationAndUpdate();
    }
  }

  getLastLocationAndUpdate() {
    //get last selected location
    location.value = GetStorage().read('lastLocation') ?? 'Islamabad, Pakistan';

    //get local data
    var data = GetStorage().read(location.value) ?? <String, dynamic>{};

    //get latest data
    getWeatherUpdate();
  }

  getWeatherUpdate() async {
    try {
      //header
      Map<String, String> header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      //Url
      String url = 'https://api.openweathermap.org/data/2.5/weather';
      Map<String, String> params = {
        'appId': '371387fb95e793ba7f284ea30da499af',
        'q': location.value,
        'units': 'metric'
      };

      Uri uriValue = Uri.parse(url).replace(queryParameters: params);
      GlobalVariables.showLoader.value = true;
      http.Response response = await http.get(uriValue, headers: header);
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      GlobalVariables.showLoader.value = false;

      if (parsedJson['cod'] == 200) {
        weatherModel.value = WeatherModel.fromJson(parsedJson);
        //store data locally
        GetStorage().write(location.value, parsedJson);
        GetXHelper.showSnackbar(message: 'Weather updated succesfully');
      } else {
        GetXHelper.showSnackbar(message: 'Something went wrong');
      }
    } catch (e) {
      GetXHelper.showSnackbar(message: e.toString());
    }
  }

  String convertTimeStampToTime(int? timeStamp) {
    String time = 'N/A';

    if (timeStamp != null) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
      time = DateFormat('hh:mm a').format(dateTime);
    }
    return time;
  }

  String getCurrentDate() {
    String date = '';
    DateTime dateTime = DateTime.now();
    date = DateFormat('EEEE | MMM dd').format(dateTime);
    return date;
  }
}
