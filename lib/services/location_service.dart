import 'package:geolocator/geolocator.dart'; // Import the Geolocator package for accessing geolocation services

// Define the LocationService class to handle location-related functionalities
class LocationService {
  // Method to get the user's current location
  Future<Position> getUserLocation() async {
    bool serviceEnabled; // Variable to store the status of location services
    LocationPermission permission; // Variable to store the status of location permissions

    // Check if location services are enabled on the device
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // If location services are disabled, throw an exception
      throw Exception('Location services are disabled.');
    }

    // Check the current permission status for accessing location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // If permission is denied, request permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // If permission is still denied, throw an exception
        throw Exception('Location permissions are denied');
      }
    }

    // Check if permission is permanently denied
    if (permission == LocationPermission.deniedForever) {
      // If permission is permanently denied, throw an exception
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // If permissions are granted, get the current position of the user
    return await Geolocator.getCurrentPosition();
  }
}
