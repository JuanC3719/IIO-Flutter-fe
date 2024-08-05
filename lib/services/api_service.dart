import 'dart:convert'; // Import for JSON encoding and decoding
import 'package:http/http.dart' as http; // Import the HTTP client package
import 'package:iio/models/place.dart'; // Import the Place model

// Define the ApiService class to handle API requests
class ApiService {
  final String baseUrl; // Base URL for the API

  // Constructor to initialize the base URL
  ApiService(this.baseUrl);

  // Generic function to fetch places from a given endpoint
  Future<List<Place>> fetchPlaces(String endpoint, double lat, double lng) async {
    // Construct the full URL with the endpoint and query parameters for latitude and longitude
    final response = await http.get(Uri.parse('$baseUrl/$endpoint?lat=$lat&lng=$lng'));

    // Check if the response status is 200 (OK)
    if (response.statusCode == 200) {
      // Decode the JSON response into a list of dynamic objects
      List<dynamic> data = json.decode(response.body);
      // Convert each JSON object into a Place object and return the list
      return data.map((json) => Place.fromJson(json)).toList();
    } else {
      // Throw an exception if the response status is not 200
      throw Exception('Failed to load places');
    }
  }

  // Function to fetch nearby fast food places
  Future<List<Place>> fetchFastFood(double lat, double lng) =>
      fetchPlaces('nearby-fastfood', lat, lng);

  // Function to fetch nearby gas stations
  Future<List<Place>> fetchGasStations(double lat, double lng) =>
      fetchPlaces('nearby-gas', lat, lng);

  // Function to fetch nearby liquor stores
  Future<List<Place>> fetchLiquorStores(double lat, double lng) =>
      fetchPlaces('nearby-liquor', lat, lng);

  // Function to fetch nearby convenience stores
  Future<List<Place>> fetchConvenienceStores(double lat, double lng) =>
      fetchPlaces('nearby-convenience', lat, lng);
}
