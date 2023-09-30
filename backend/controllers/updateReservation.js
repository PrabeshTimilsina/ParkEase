const cron = require("node-cron");
const UserReservation = require("../models/userReservation");
const ParkingLocation = require("../models/locationModel");

// Function to check and update expired reservations
const updateExpiredReservations = async () => {
  try {
    console.log("hey 1 minut happened");
    const currentTime = new Date();

    // Find expired reservations
    const expiredReservations = await UserReservation.find({
      expirationTime: { $lte: currentTime },
    });
    console.log(expiredReservations);
    // Update parking spaces and reservations
    for (const reservation of expiredReservations) {
      const parkingSpace = await ParkingLocation.findById(
        reservation.locationId
      )
        .select("categories")
        .elemMatch("categories", { vehicleType: reservation.vehicleType });
      console.log(parkingSpace);
      if (parkingSpace) {
        const categoryToUpdate = parkingSpace.categories.find(
          (category) => category.vehicleType === reservation.vehicleType
        );
        if (categoryToUpdate) {
          // Update the capacity of the found category
          categoryToUpdate.capacity += 1;
          await parkingSpace.save();
        }
      }

      // reservation.isOccupied = false;
      await reservation.deleteOne();
    }
  } catch (error) {
    console.error("Error updating expired reservations:", error);
  }
};

// Schedule the task to run every minute (adjust as needed)
//cron.schedule('* * * * *', updateExpiredReservations);
module.exports = updateExpiredReservations;
