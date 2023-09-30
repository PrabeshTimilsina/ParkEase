const mongoose = require("mongoose");

// Schema for a User's Parking Reservation
const userReservationSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User", // Reference to the User collection
    required: true,
  },
  locationId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "ParkingLocation", // Reference to the ParkingLocation collection
    required: true,
  },

  vehicleType: {
    type: String,
    required: true,
  },
  startTime: {
    type: Date,
    default: Date.now, // This will set the startTime to the current date and time when the reservation is created.
  },
  expirationTime: {
    type: Date,
    required: true, // This will set the startTime to the current date and time when the reservation is created.
  },
  // reservedSpaceNumber: {
  //   type: Number,
  //   required: true,
  // },

  payment: {
    transatctionId: {
      type: String,
      required: true,
    },
    gateway: {
      type: String,
      required: true,
    },
  },
});

// Model for User's Parking Reservation
module.exports = mongoose.model("UserReservation", userReservationSchema);
