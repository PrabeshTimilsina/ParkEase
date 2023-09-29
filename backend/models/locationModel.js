const mongoose = require("mongoose");
// const parkingSpaceSchema = new mongoose.Schema({
//   spaceNumber: {
//     type: Number,
//     required: true,
//   },
//   isOccupied: {
//     type: Boolean,
//     default: false,
//   },
//   vehicleType: {
//     type: String,
//     required: true,
//   },
//   // You can add more attributes here specific to a parking space.
// });

// Schema for a Parking Location
const parkingLocationSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  location: {
    address: {
      type: String,
      required: true,
    },
    latitude: {
      type: Number,
      required: true,
    },
    longitude: {
      type: Number,
      required: true,
    },
  },
  // Embed the parking spaces within the location
  // parkingSpaces: [parkingSpaceSchema],
  rating: {
    type: Number,
    default: 0,
  },
  categories: [
    {
      vehicleType: {
        type: String,
        required: true,
      },
      rate: {
        type: Number,
        required: true,
      },
      capacity: {
        type: Number,
        required: true,
      },
    },
  ],
  reviews: [
    {
      user: {
        type: mongoose.Schema.ObjectId,
        ref: "User",
        required: "true",
      },
      name: {
        type: String,
        required: true,
      },
      rating: {
        type: Number,
        required: true,
      },
      comment: {
        type: String,
      },
    },
  ],
  //rate,rating,
  // You can add more attributes here, such as capacity, operating hours, etc.
});

// Model for Parking Location
module.exports = mongoose.model("ParkingLocation", parkingLocationSchema);
