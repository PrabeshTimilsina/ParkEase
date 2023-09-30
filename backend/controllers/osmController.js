const axios = require("axios");
const mongoose = require("mongoose");
const ParkingLocation = require("../models/locationModel"); // Import your Mongoose model
const Redis = require("ioredis");
const { raw } = require("express");
// Define the base URL for the OSRM API and any options you need
const osrmBaseURL = "http://127.0.0.1:5000/route/v1/driving/";
const options = "?steps=true";

// Define the starting point (latitude and longitude)
const redis = new Redis({
  host: "localhost", // Replace with your Redis server hostname or IP
  port: 6379, // Replace with your Redis server port
  db: 0, // Replace with the Redis database number you want to use
}); // Replace with your starting point coordinates

// Array to store destination information (including latitude, longitude, and distance)
//const destinationsInfo = [];

// // Function to calculate distances from the starting point to each destination
// async function calculateDistances() {
//     try {
//       // Fetch all parking locations from the database
//       const parkingLocations = await ParkingLocation.find({}, 'location name'); // Only fetch latitude, longitude, and name

//       // Calculate and display the distance for each parking location
//       for (const desiredlocation of parkingLocations) {
//         const destination = `${desiredlocation.location.longitude},${desiredlocation.location.latitude}`;
//         const osrmURL = `${osrmBaseURL}${startPoint};${destination}${options}`;

//         try {
//           const response = await axios.get(osrmURL);
//           const route = response.data.routes[0];
//           const distance = route.distance; // Extract distance from the response

//           // Store destination information in the destinationsInfo array
//           destinationsInfo.push({
//             name: desiredlocation.location.name,
//             latitude: desiredlocation.location.latitude,
//             longitude: desiredlocation.location.longitude,
//             distance: distance,
//           });

//           console.log(`Distance from ${startPoint} to ${location.name}: ${distance} meters`);
//         } catch (error) {
//           console.error(`Error calculating distance: ${error.message}`);
//         }
//       }

//       // Sort the destinationsInfo array by distance in ascending order
//       destinationsInfo.sort((a, b) => a.distance - b.distance);

//       // Now, the destinationsInfo array contains objects with name, latitude, longitude, and distance sorted by distance
//       console.log("Destinations Info (Sorted by Distance):", destinationsInfo);
//       return destinationsInfo;
//     } catch (error) {
//       console.error(`Error fetching parking locations: ${error.message}`);
//     }
//   }

//   module.exports=calculateDistances;

//The next approach that needs to be discussed is :
// Function to calculate distances from the user-provided location to nearby parking locations
async function calculateDistances(latitude, longitude, vehicleType) {
  try {
    // Calculate latitude bounds for filtering parking locations
    const latitudeDifferenceThreshold = 0.3; // Approximately 50 kilometers in latitude degrees
    const minLatitude = latitude - latitudeDifferenceThreshold;
    const maxLatitude = latitude + latitudeDifferenceThreshold;
    console.log(minLatitude, maxLatitude);
    //console.log("hey we are in the distance calculation");
    // Fetch parking locations from the database within the latitude bounds
    const parkingLocations = await ParkingLocation.find({
      "location.latitude": { $gte: minLatitude, $lte: maxLatitude },
    });
    //console.log(parkingLocations)
    const destinationsInfo = [];

    // Iterate over each parking location
    for (const desiredLocation of parkingLocations) {
      // Check if there are available parking spaces for the given vehicle type
      let availableSpaces = await hasAvailableSpaces(
        desiredLocation,
        vehicleType
      );
      //  console.log(availableSpaces)
      if (availableSpaces > 0) {
        //console.log("If available spaces")
        console.log(
          desiredLocation.location.latitude,
          desiredLocation.location.longitude
        );
        const destination = `${desiredLocation.location.longitude},${desiredLocation.location.latitude}`;
        const osrmURL = `${osrmBaseURL}${longitude},${latitude};${destination}${options}`;

        try {
          // Calculate distance using the OSRM API
          const response = await axios.get(osrmURL);
          //console.log(response.data)
          const route = response.data.routes[0];
          const distance = route.distance; // Extract distance from the response
          const duration = route.duration;

          // Store destination information in the destinationsInfo array
          destinationsInfo.push({
            _id: desiredLocation._id,
            name: desiredLocation.name,
            latitude: desiredLocation.location.latitude,
            longitude: desiredLocation.location.longitude,
            distance: distance,
            duration: duration,
            availableSpaces: availableSpaces,
          });

          console.log(
            `Distance from user location to ${desiredLocation.location.address}: ${distance} meters`
          );
        } catch (error) {
          console.error(`Error calculating distance: ${error.message}`);
        }
      }
    }

    // Sort the destinationsInfo array by distance in ascending order
    destinationsInfo.sort((a, b) => a.distance - b.distance);

    // Now, the destinationsInfo array contains objects with name, latitude, longitude, and distance sorted by distance
    console.log("Destinations Info (Sorted by Distance):", destinationsInfo);
    return destinationsInfo;
  } catch (error) {
    console.error(
      `Error fetching and filtering parking locations: ${error.message}`
    );
    throw error; // Re-throw the error to be caught by the caller
  }
}

async function hasAvailableSpaces(parkingLocation, vehicleType) {
  if (parkingLocation.parkingType == "regulated") {
    // console.log("Entered Regulated")
    // console.log(parkingLocation,vehicleType)
    // Filter the parking spaces based on vehicle type and occupancy status
    const availableSpaces = parkingLocation.categories.filter(
      (space) => space.vehicleType === vehicleType && space.capacity > 0
    );
    if (availableSpaces.length > 0) {
      return availableSpaces[0].capacity;
    } else {
      return 0;
    }
  } else {
    // console.log("Entered UnRegulated")

    // console.log(response.data);
    const rawData = await redis.get(ParkingLocation._id);
    console.log(rawData);
    const data = JSON.parse(rawData);
    const { bikeCapacity, carCapaity } = data;

    const availableSpaces = await parkingLocation.categories.filter(
      (space) => space.vehicleType === vehicleType
    );
    if (vehicleType == "Car") {
      //console.log("Entered Car")
      // console.log(availableSpaces[0].capacity)
      if (availableSpaces[0].capacity - carCapaity > 0) {
        // console.log(availableSpaces[0].capacity-carCapaity)
        return availableSpaces[0].capacity - carCapaity;
      } else {
        return 0;
      }
    } else {
      // console.log(availableSpaces[0].capacity)
      if (availableSpaces[0].capacity - bikeCapacity > 0) {
        //console.log(availableSpaces[0].capacity-bikeCapacity)
        return availableSpaces[0].capacity - bikeCapacity;
      } else {
        return 0;
      }
    }
  }
}

module.exports = calculateDistances;