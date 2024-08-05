# "Is It Open" App

**"Is It Open"** is a fullstack mobile application designed to help users quickly find out if local businesses such as fast food restaurants, gas stations, liquor stores, and convenience stores are open within their area. It combines a user-friendly Flutter frontend with a powerful Node.js backend to deliver real-time information using the Google Maps Places API.

## Features

- **Location-Based Search**: Retrieve and display nearby businesses based on your current location.
- **Open Places Display**: Shows which businesses are currently open within your specified radius.
- **Navigation Options**: Click on an address to get directions using Google Maps.
- **Upcoming Integration**: Direct ordering via Uber Eats (in development).

## Technology Stack

- **Frontend**:

  - **Flutter**: For building the mobile application with a responsive and intuitive user interface.
  - **Geolocator**: For accessing device location.
  - **HTTP**: For making network requests.
  - **URL Launcher**: For opening URLs in external applications.

- **Backend**:
  - **Node.js**: For handling server-side logic and API requests.
  - **Express**: For creating API endpoints and managing routes.
  - **Winston**: For advanced logging and error tracking.
  - **dotenv**: For managing environment variables.
  - **Google Maps Places API**: For searching and retrieving information about nearby places.

## API Endpoints

- **Get Nearby Gas Stations**

  - **Endpoint:** `/api/nearby-gas`
  - **Method:** GET
  - **Query Parameters:** `lat`, `lng`
  - **Response:** List of nearby gas stations (name, vicinity, isOpen, placeId)

- **Get Nearby Fast Food**

  - **Endpoint:** `/api/nearby-fastfood`
  - **Method:** GET
  - **Query Parameters:** `lat`, `lng`
  - **Response:** List of nearby fast food restaurants (name, vicinity, isOpen, placeId)

- **Get Nearby Liquor Stores**

  - **Endpoint:** `/api/nearby-liquor`
  - **Method:** GET
  - **Query Parameters:** `lat`, `lng`
  - **Response:** List of nearby liquor stores (name, vicinity, isOpen, placeId)

- **Get Nearby Convenience Stores**
  - **Endpoint:** `/api/nearby-convenience`
  - **Method:** GET
  - **Query Parameters:** `lat`, `lng`
  - **Response:** List of nearby convenience stores (name, vicinity, isOpen, placeId)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- Google Maps Places API for place search functionality.
- Winston for advanced logging capabilities.
- dotenv for managing environment variables.
- Flutter for building the application.
- Geolocator for location services.
- HTTP for making HTTP requests.
- URL Launcher for opening URLs.
