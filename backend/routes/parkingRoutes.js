const express = require("express");

const router = express.Router();
const {
  confirmparking,
  registerLocation,
  getAvailableParkingSpaces,
  mybookingDetails,
  createParkingReview,
  getAllReviews,
  deleteReview,
} = require("../controllers/parkingController");
const { isUserAuthenticated } = require("../middleware/auth");
router.route("/bookparking").post(confirmparking);
router.route("/registerlocation").post(registerLocation);
router.route("/availableparkings").get(getAvailableParkingSpaces);
router.route("/mybookingdetails").get(mybookingDetails);
router.route("/review").put(isUserAuthenticated, createParkingReview);
router
  .route("/reviews/")
  .get(getAllReviews)
  .delete(isUserAuthenticated, deleteReview);
module.exports = router;
