import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/screens/location/location_viewmodel.dart';
import 'package:weather_app/widgets/custom_textfields.dart';

class LocationView extends StatelessWidget {
  LocationView({super.key});
  final LocationViewModel viewModel = Get.put(LocationViewModel());

  @override
  Widget build(BuildContext context) {
    // Getting screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
        child: Column(
          children: [
            CustomTextField(
              hint: 'Search Location...',
              prefixIcon: Icons.location_on,
              onChanged: (value) {
                viewModel.onSearchLocation(value);
              },
            ),
            SizedBox(
              height: screenHeight * 0.03, // Responsive spacing
            ),
            Expanded(
              child: Obx(() => viewModel.filteredLocationsList.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        return listViewItem(index, screenWidth, screenHeight);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: screenHeight * 0.02, // Responsive spacing
                        );
                      },
                      itemCount: viewModel.filteredLocationsList.length)
                  : const Center(child: Text('No Location Found'))),
            ),
          ],
        ),
      ),
    );
  }

  Widget listViewItem(int index, double screenWidth, double screenHeight) {
    return ListTile(
      tileColor: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            screenWidth * 0.03), // Responsive border radius
      ),
      onTap: () {
        viewModel.onLocationSelection(index);
      },
      leading: Icon(
        Icons.location_on,
        color: Colors.white,
        size: screenHeight * 0.03, // Responsive icon size
      ),
      title: Text(
        viewModel.filteredLocationsList[index],
        style: TextStyle(
          color: Colors.white,
          fontSize: screenHeight * 0.02, // Responsive font size
        ),
      ),
    );
  }
}
