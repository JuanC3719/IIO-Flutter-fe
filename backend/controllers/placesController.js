// controllers/placesController.js
require("dotenv").config(); // Load environment variables from a .env file into process.env

const { Client } = require("@googlemaps/google-maps-services-js"); // Import the Google Maps client library
const logger = require("../logger"); // Import the logger

// Initialize a new Google Maps client with the API key from environment variables
const client = new Client({
  key: process.env.API_KEY, // Replace with your actual API key
});

/**
 * Fetches nearby places of a specific type and keyword based on user location.
 * @param {Object} req - The request object, containing query parameters for latitude and longitude.
 * @param {Object} res - The response object, used to send back the JSON response.
 * @param {string} type - The type of place to search for (e.g., "gas_station", "restaurant").
 * @param {string} keyword - The keyword(s) to refine the search (e.g., "gas station", "fast food").
 */
function getNearbyPlaces(req, res, type, keyword) {
  const { lat, lng } = req.query; // Extract latitude and longitude from the request query parameters
  if (!lat || !lng || isNaN(lat) || isNaN(lng)) {
    logger.error("Invalid latitude or longitude.");
    return res.status(400).send("Invalid latitude or longitude.");
  }
  const userLatitude = parseFloat(lat); // Convert latitude to a floating-point number
  const userLongitude = parseFloat(lng); // Convert longitude to a floating-point number

  // Perform a nearby search request using the Google Maps client
  client
    .placesNearby({
      params: {
        location: { lat: userLatitude, lng: userLongitude }, // User's location
        radius: 3200, // 5km radius (3200 meters) hardcoded until user input is created in Flutter
        type: [type], // Type of place to search for
        keyword: keyword, // Keywords to refine the search
        key: process.env.API_KEY, // API key from environment variables
      },
    })
    .then((response) => {
      const places = response.data.results; // Extract results from the API response
      console.log(places); // Log the results for debugging purposes
      const processedPlacesData = []; // Initialize an array to store processed place data

      // Process each place in the results
      places.forEach((place) => {
        let isOpen = false; // Initialize isOpen as false
        // Check if the place has opening hours information and if it's currently open
        if (place.opening_hours && place.opening_hours.open_now) {
          isOpen = true;
        }

        // Add processed place data to the array
        processedPlacesData.push({
          name: place.name, // Name of the place
          vicinity: place.vicinity, // Vicinity of the place
          isOpen: isOpen, // Whether the place is currently open
          placeId: place.place_id, // Unique place ID
        });
      });

      res.json(processedPlacesData); // Send the processed data as a JSON response
    })
    .catch((e) => {
      logger.error(`Error fetching places: ${e.message}`); // Log the error
      res.status(500).send("Error fetching places"); // Send a 500 status code and error message
    });
}

module.exports = {
  // Controller method to get nearby gas stations
  getNearbyGas: (req, res) => {
    getNearbyPlaces(req, res, "gas_station", "gas|gas station");
  },

  // Controller method to get nearby fast food restaurants
  getNearbyFastFood: (req, res) => {
    getNearbyPlaces(
      req,
      res,
      "restaurant",
      "delivery|takeout|dine in|food|drive thru"
    );
  },

  // Controller method to get nearby liquor stores
  getNearbyLiquor: (req, res) => {
    getNearbyPlaces(req, res, "liquor_store", "liquor store|liquor");
  },

  // Controller method to get nearby convenience stores
  getNearbyConvenience: (req, res) => {
    getNearbyPlaces(
      req,
      res,
      "convenience_store",
      "convenience store|food|drinks|snacks|7 eleven"
    );
  },
};
