// routes/placesRoutes.js

const express = require("express"); // Import the Express library
const router = express.Router(); // Create a new router instance
const placesController = require("../controllers/placesController"); // Import the places controller

// Define a route for getting nearby gas stations
// When a GET request is made to /nearby-gas, call the getNearbyGas method from placesController
router.get("/nearby-gas", placesController.getNearbyGas);

// Define a route for getting nearby fast food restaurants
// When a GET request is made to /nearby-fastfood, call the getNearbyFastFood method from placesController
router.get("/nearby-fastfood", placesController.getNearbyFastFood);

// Define a route for getting nearby liquor stores
// When a GET request is made to /nearby-liquor, call the getNearbyLiquor method from placesController
router.get("/nearby-liquor", placesController.getNearbyLiquor);

// Define a route for getting nearby convenience stores
// When a GET request is made to /nearby-convenience, call the getNearbyConvenience method from placesController
router.get("/nearby-convenience", placesController.getNearbyConvenience);

module.exports = router; // Export the router instance to be used in other parts of the application
