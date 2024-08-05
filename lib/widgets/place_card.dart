import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:iio/models/place.dart';
import 'package:logger/logger.dart';

  // Create a global logger instance
  final Logger logger = Logger();

/// A stateless widget that represents a card displaying information about a place.
class PlaceCard extends StatelessWidget {
  // The place to be displayed in this card
  final Place place;

  // Constructor for PlaceCard, requiring a Place object
  const PlaceCard({required this.place, super.key});

  /// Launches Google Maps with directions to the place's address.
  void _launchMaps() async {
    // Create a URI for Google Maps with the destination address encoded
    final Uri mapsUri = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=${Uri.encodeComponent(place.address)}');

    // Check if the maps URI can be launched
    if (await canLaunchUrl(mapsUri)) {
      // Launch the maps URI in an external application
      await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
    } else {
      // Print an error message if the URI cannot be launched
      logger.e('Could not launch Maps');
    }
  }

  /// Shows a confirmation dialog asking the user if they want to open Google Maps.
  void _showMapConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Open Maps?'),
          content: Text('Do you want to use Google Maps to get to ${place.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close dialog when Cancel is pressed
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _launchMaps(); // Launch Google Maps
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  /// Launches the Uber Eats app if installed, otherwise opens the app store.
  void _launchUberEats() async {
    const String uberEatsUri = 'ubereats://'; // URI for Uber Eats app
    const String appStoreUri = 'https://apps.apple.com/us/app/uber-eats-food-delivery/id1058959277'; // iOS App Store link
    const String playStoreUri = 'https://play.google.com/store/apps/details?id=com.ubercab.eats'; // Android Play Store link

    // Check if the Uber Eats URI can be launched
    if (await canLaunchUrl(Uri.parse(uberEatsUri))) {
      // Launch the Uber Eats app
      await launchUrl(Uri.parse(uberEatsUri), mode: LaunchMode.externalApplication);
    } else {
      // If the Uber Eats app is not installed, fallback to the App Store or Play Store
      if (await canLaunchUrl(Uri.parse(appStoreUri))) {
        await launchUrl(Uri.parse(appStoreUri), mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(Uri.parse(playStoreUri))) {
        await launchUrl(Uri.parse(playStoreUri), mode: LaunchMode.externalApplication);
      } else {
        // Print an error message if neither the app nor the stores can be launched
        logger.e('Could not launch Uber Eats or app stores');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // ListTile displaying the place's name and address
          ListTile(
            title: Text(place.name),
            subtitle: Text(place.address),
            onTap: () => _showMapConfirmationDialog(context), // Show map confirmation dialog on tap
          ),
          // Elevated button to order on Uber Eats
          ElevatedButton(
            onPressed: _launchUberEats,
            child: const Text('Click here to order on Uber Eats'),
          ),
        ],
      ),
    );
  }
}
