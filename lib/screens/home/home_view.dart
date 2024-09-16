import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/screens/home/home_viewmodel.dart';
import 'package:weather_app/widgets/loader_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeViewModel viewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xff7CA9FF),
      appBar: appBar(),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff3C6FD1), Color(0xff7CA9FF)],
                stops: [0.25, 0.87],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      screenWidth * 0.04, // Responsive horizontal padding
                  // vertical: screenHeight * 0.02, // Responsive vertical padding
                ),
                child: Column(
                  children: [
                    iconAndTemperature(screenWidth, screenHeight),
                    SizedBox(height: screenHeight * 0.01), // Responsive spacing
                    const Divider(),
                    SizedBox(
                        height: screenHeight * 0.023), // Responsive spacing

                    weatherValues(screenWidth, screenHeight),
                    
                  ],
                ),
              ),
            ),
            const LoaderView(),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Obx(
        () => Text(viewModel.location.value),
      ),
      actions: [
        IconButton(
            onPressed: () {
              viewModel.changeLocation();
            },
            icon: const Icon(Icons.location_on_outlined)),
      ],
    );
  }

  Widget iconAndTemperature(double screenWidth, double screenHeight) {
    return Column(
      children: [
        weatherImage(screenWidth),
        SizedBox(height: screenHeight * 0.01), // Responsive spacing
        Text(
          viewModel.getCurrentDate(),
          style: TextStyle(
            fontSize: screenHeight * 0.022, // Responsive font size
            color: Colors.white,
          ),
        ),
        SizedBox(height: screenHeight * 0.01), // Responsive spacing
        Wrap(
          children: [
            Obx(
              () => Text(
                textAlign: TextAlign.center,
                (viewModel.weatherModel.value.main?.temp ?? 00)
                    .toStringAsFixed(0),
                style: TextStyle(
                    fontSize: screenHeight * 0.07, // Responsive font size
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Text(
              'o',
              style: TextStyle(
                  fontSize: screenHeight * 0.03, // Responsive font size
                  color: Colors.white,
                  fontFeatures: [FontFeature.superscripts()]),
            ),
          ],
        ),
        Obx(() => Text(
              textAlign: TextAlign.center,
              viewModel.weatherModel.value.weather?.first.main ?? 'N/A',
              style: TextStyle(
                fontSize: screenHeight * 0.027, // Responsive font size
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            )),
      ],
    );
  }

  Widget weatherImage(double screenWidth) {
    return CachedNetworkImage(
      imageUrl:
          'https://openweathermap.org/img/wn/${viewModel.weatherModel.value.weather?.first.icon}@4x.png',
      height: screenWidth * 0.3, // Responsive image size
      width: screenWidth * 0.3, // Responsive image size
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Image.asset('assets/images/clouds.png'),
        );
      },
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        );
      },
    );
  }

  Widget weatherValues(double screenWidth, double screenHeight) {
    return Column(
      children: [
        Row(
          children: [
            Obx(
              () => detailItem(
                  title: 'Minimum',
                  value:
                      '${viewModel.weatherModel.value.main?.tempMin ?? 'N/A'}',
                  icon: CupertinoIcons.down_arrow,
                  unit: '',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight),
            ),
            SizedBox(width: screenWidth * 0.03), // Responsive spacing
            Obx(
              () => detailItem(
                  title: 'Maximum',
                  value:
                      '${viewModel.weatherModel.value.main?.tempMax ?? 'N/A'}',
                  icon: CupertinoIcons.up_arrow,
                  unit: '',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight),
            )
          ],
        ),
        SizedBox(height: screenHeight * 0.02), // Responsive spacing
        Row(
          children: [
            Obx(
              () => detailItem(
                  title: 'Wind',
                  value: '${viewModel.weatherModel.value.wind?.speed ?? 'N/A'}',
                  icon: Icons.wind_power,
                  unit: 'm/s',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight),
            ),
            SizedBox(width: screenWidth * 0.03),
            Obx(
              () => detailItem(
                  title: 'Feel Like',
                  value:
                      '${viewModel.weatherModel.value.main?.feelsLike ?? 'N/A'}',
                  icon: Icons.cloudy_snowing,
                  unit: '',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          children: [
            Obx(
              () => detailItem(
                  title: 'Pressure',
                  value:
                      '${viewModel.weatherModel.value.main?.pressure ?? 'N/A'}',
                  icon: Icons.thermostat,
                  unit: '',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight),
            ),
            SizedBox(width: screenWidth * 0.03),
            Obx(
              () => detailItem(
                  title: 'Humidity',
                  value:
                      '${viewModel.weatherModel.value.main?.humidity ?? 'N/A'}',
                  icon: Icons.water_drop_outlined,
                  unit: '',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight),
            )
          ],
        ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          children: [
            Obx(
              () => detailItem(
                  title: 'Sun Rise',
                  value: viewModel.convertTimeStampToTime(
                      viewModel.weatherModel.value.sys?.sunrise),
                  icon: Icons.sunny,
                  unit: '',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight),
            ),
            SizedBox(width: screenWidth * 0.03),
            Obx(
              () => detailItem(
                  title: 'Sun Set',
                  value: viewModel.convertTimeStampToTime(
                      viewModel.weatherModel.value.sys?.sunset),
                  icon: Icons.sunny_snowing,
                  unit: '',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          children: [
            Obx(
              () => detailItem(
                  title: 'Latitude',
                  value: '${viewModel.weatherModel.value.coord?.lat ?? 'N/A'}',
                  icon: Icons.location_on,
                  unit: '',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight),
            ),
            SizedBox(width: screenWidth * 0.03),
            Obx(
              () => detailItem(
                  title: 'Longitude',
                  value: '${viewModel.weatherModel.value.coord?.lon ?? 'N/A'}',
                  icon: Icons.location_on,
                  unit: '',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight),
            ),
          ],
        ),
      ],
    );
  }

  Widget detailItem({
    required String title,
    required String value,
    required IconData icon,
    required String unit,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Expanded(
      child: Container(
        // margin: EdgeInsets.only(top: screenHeight * 0.01),
        padding: EdgeInsets.all(screenHeight * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.17),
        ),
        child: Row(
          children: [
            Icon(icon, size: screenWidth * 0.08),
            SizedBox(width: screenWidth * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value != 'N/A' ? '$value $unit' : value,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight * 0.018,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenHeight * 0.017,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
