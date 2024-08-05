import 'package:flutter/material.dart';
import 'package:iio/screens/nearby_places_screen.dart'; 

// The main function is the entry point of the Flutter application
void main() {
  runApp(const MyApp()); // runApp is a built-in Flutter function that initializes the app
}

// MyApp is a StatelessWidget that represents the root of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor with a key parameter, useful for widget identification

  @override
  Widget build(BuildContext context) {
    // The build method describes the part of the user interface represented by this widget
    return MaterialApp(
      title: 'Is It Open?', // The title of the application, used by the OS to identify the app
      theme: ThemeData(
        primarySwatch: Colors.blue, // The primary theme color for the application
      ),
      home: const IndexScreen(), // The home property sets the default route of the app to IndexScreen
    );
  }
}

// IndexScreen is a StatelessWidget that represents the main screen of the application
class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key}); // Constructor with a key parameter, useful for widget identification

  @override
  Widget build(BuildContext context) {
    // The build method describes the part of the user interface represented by this widget
    return Scaffold(
      appBar: AppBar(
        // The AppBar widget creates a material design app bar
        backgroundColor: const Color(0xFF001529), // Sets the background color of the app bar to a specific color
      ),
      body: const Padding(
        // The Padding widget adds padding to its child widget
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24), // Specifies the amount of padding
        child: NearbyPlacesScreen(), // The child widget that represents the main content of the screen, NearbyPlacesScreen
      ),
    );
  }
}
