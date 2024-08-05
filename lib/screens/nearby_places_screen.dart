import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // Import geolocation package
import 'package:iio/services/api_service.dart'; // Import API service
import 'package:iio/services/location_service.dart'; // Import location service
import 'package:iio/models/place.dart'; // Import place model
import 'package:iio/widgets/place_card.dart'; // Import place card widget

// Define the NearbyPlacesScreen as a StatefulWidget to manage state changes
class NearbyPlacesScreen extends StatefulWidget {
  const NearbyPlacesScreen({super.key}); // Constructor with a key parameter

  @override
  State<NearbyPlacesScreen> createState() => _NearbyPlacesScreenState(); // Create the state for this widget
}

// Define the state class for NearbyPlacesScreen
class _NearbyPlacesScreenState extends State<NearbyPlacesScreen> {
  Position? _userLocation; // Variable to store user's location
  bool _isLoading = false; // Variable to indicate loading state
  String? _locationError; // Variable to store location errors
  String? _error; // Variable to store other errors
  List<Place> _places = []; // List to store nearby places
  bool _allClosed = false; // Variable to indicate if all places are closed
  bool _showResults = false; // State to control showing results

  // Instantiate the location and API services
  final LocationService _locationService = LocationService();
  final ApiService _apiService = ApiService('https://iio-be.vercel.app/api');

  // Function to handle enabling location services
  void _handleEnableLocation() async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });
    try {
      Position position = await _locationService.getUserLocation(); // Get user location
      setState(() {
        _userLocation = position; // Set user location
        _locationError = null; // Clear location error
        _showResults = false; // Reset results visibility
      });
    } catch (e) {
      setState(() {
        _locationError = e.toString(); // Set location error
      });
    }
    setState(() {
      _isLoading = false; // Set loading state to false
    });
  }

  // Function to fetch nearby places
  Future<void> _fetchNearbyPlaces(
      Future<List<Place>> Function(double, double) fetchFunction) async {
    if (_userLocation == null) return; // If user location is not set, return

    setState(() {
      _isLoading = true; // Set loading state to true
      _showResults = true; // Show results when fetching places
    });

    try {
      List<Place> places = await fetchFunction(
          _userLocation!.latitude, _userLocation!.longitude); // Fetch places using the provided function
      setState(() {
        _places = places.where((place) => place.isOpen).toList(); // Filter open places
        _allClosed = _places.isEmpty; // Check if all places are closed
        _error = null; // Clear error
      });
    } catch (e) {
      setState(() {
        _error = e.toString(); // Set error
      });
    }

    setState(() {
      _isLoading = false; // Set loading state to false
    });
  }

  // Function to reset search results
  void _resetSearch() {
    setState(() {
      _showResults = false; // Hide results
      _places = []; // Clear results
      _error = null; // Clear errors
    });
  }

  // Build method to describe the part of the user interface represented by this widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Is It Open?', // Title of the app bar
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
        backgroundColor: const Color(0xFF001529), // Set the background color of the app bar
        actions: [
          if (_showResults) // Show back button if results are being displayed
            IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white, // Set the arrow color to white
              onPressed: () {
                _resetSearch(); // Reset search when back button is pressed
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20), // Add padding around the body
        child: Column(
          children: [
            if (!_showResults) // Show buttons only if results are not being displayed
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the buttons vertically
                    children: [
                      ElevatedButton(
                        onPressed: _isLoading ? null : _handleEnableLocation, // Disable button if loading
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Enable Location Services'), // Button to enable location services
                      ),
                      const SizedBox(height: 10), // Add space between buttons
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () => _fetchNearbyPlaces(_apiService.fetchFastFood), // Fetch fast food places
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Find Nearby Fast Food'), // Button to find nearby fast food
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () => _fetchNearbyPlaces(_apiService.fetchGasStations), // Fetch gas stations
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Find Nearby Gas Stations'), // Button to find nearby gas stations
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () => _fetchNearbyPlaces(_apiService.fetchLiquorStores), // Fetch liquor stores
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Find Nearby Liquor Stores'), // Button to find nearby liquor stores
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () => _fetchNearbyPlaces(_apiService.fetchConvenienceStores), // Fetch convenience stores
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Find Nearby Convenience Stores'), // Button to find nearby convenience stores
                      ),
                    ],
                  ),
                ),
              ),
            if (_locationError != null) // Display location error if any
              Card(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_locationError!),
                ),
              ),
            if (_error != null) // Display other errors if any
              Card(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_error!),
                ),
              ),
            if (_allClosed && _error == null) // Display message if all places are closed
              const Card(
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'All places nearby in your radius are currently closed.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            if (_showResults) // Show results only if _showResults is true
              Expanded(
                child: ListView.builder(
                  itemCount: _places.length, // Number of places to display
                  itemBuilder: (context, index) {
                    return PlaceCard(place: _places[index]); // Display each place using PlaceCard widget
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
