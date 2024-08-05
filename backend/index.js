// index.js
require("dotenv").config(); // Load environment variables from a .env file into process.env
const winston = require("winston");

const express = require("express"); // Import the Express library
const cors = require("cors"); // Import the CORS middleware to enable Cross-Origin Resource Sharing
const placesRouter = require("./routes/placesRoutes"); // Import the router from placesRoutes

const app = express(); // Create an instance of an Express application
const port = process.env.PORT || 3000; // Define the port number the server will listen on

app.use(
  cors({
    origin: true, // Allow all origins only for testing purposes, in production, set to required frontend origin
    methods: ["GET", "POST", "PUT", "DELETE"], // Allow specific HTTP methods
  })
);

// Logger configuration
const logger = winston.createLogger({
  level: "info",
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json()
  ),
  transports: [new winston.transports.Console()],
});

// Log incoming requests
app.use((req, res, next) => {
  logger.info(`Incoming request: ${req.method} ${req.url}`);
  next();
});

// Mount the placesRouter on the "/api" path
// All routes defined in placesRouter will be prefixed with "/api"
app.use("/api", placesRouter);

// Start the server and listen on the specified port
app.listen(port, () => {
  console.log(`Server listening on port ${port}`); // Log a message to indicate the server is running
});
