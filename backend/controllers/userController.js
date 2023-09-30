const User = require("../models/userModel");
const ErrorHandler = require("../utils/errorHandler");
const sendEmail = require("../utils/sendEmail.js");
const catchAsyncError = require("../middleware/catchAsyncError");
const sendToken = require("../utils/jwtToken");
const crypto = require("crypto");
//Register a User

exports.registerUser = catchAsyncError(async (req, res, next) => {
  const { name, email, password } = req.body;
  const user = await User.create({
    name,
    email,
    password,
    profile_image: {
      public_id: "Sample_id",
      url: "profile_pic",
    },
  });
  sendToken(user, 201, res);
});

//Login User
exports.loginUser = catchAsyncError(async (req, res, next) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return next(new ErrorHandler("Please Enter Email And Password", 400));
  }
  const user = await User.findOne({ email }).select("+password");
  if (!user) {
    return next(new ErrorHandler("Invalid Email or Password", 401));
  }
  const isPasswordMatched = await user.comparePassword(password);
  if (!isPasswordMatched) {
    return next(new ErrorHandler("Invalid Email or Password", 401));
  }

  sendToken(user, 200, res);
});

//Logout User
exports.logout = catchAsyncError(async (req, res, next) => {
  res.cookie("token", null, {
    expires: new Date(Date.now()),
    httpOnly: true,
  });
  res.status(200).json({
    success: true,
    message: "Logged out succesfully.",
  });
});
exports.forgotPasswprd = catchAsyncError(async (req, res, next) => {
  const user = await User.findOne({ email: req.body.email });
  if (!user) {
    return next(new ErrorHandler("User not Found", 404));
  }
  const resetToken = await user.getResetPasswordToken();
  await user.save({ validateBeforeSave: false });
  console.log({ resetToken });
  const resetPasswordUrl = `${req.protocol}://${req.get(
    "host"
  )}/user/password/reset/${resetToken}`;
  const message = `Your password reset token is : \n\n
  ${resetPasswordUrl}\n\n If you have not requested this email then please ignore it.`;
  const options = {
    email: user.email,
    subject: "Reset Password",
    message,
  };
  try {
    await sendEmail(options);
    res.status(200).json({
      success: true,
      message: `Email sent to ${user.email}`,
    });
  } catch (error) {
    user.resetPasswordToken = undefined;
    user.resetPasswordToken = undefined;
    await user.save({ validateBeforeSave: false });
    return next(new ErrorHandler(error.message, 500));
  }
});
exports.resetPassword = catchAsyncError(async (req, res, next) => {
  //creating token hash

  const resetPasswordToken = crypto
    .createHash("sha256")
    .update(req.params.token)
    .digest("hex");

  console.log({ resetPasswordToken });
  const user = await User.findOne({
    resetPasswordToken,
    resetPasswordExpire: { $gt: Date.now() },
  });
  if (!user) {
    return next(new ErrorHandler("Reset Password Token is not valid.", 404));
  }
  if (req.body.password !== req.body.confirmPassword) {
    return next(new ErrorHandler("Password doesn't match.", 400));
  }
  user.password = req.body.password;
  user.resetPasswordToken = undefined;
  user.resetPasswordExpire = undefined;
  await user.save();
  sendToken(user, 200, res);
});

exports.getUserDetail = catchAsyncError(async (req, res, next) => {
  const user = await User.findById(req.user.id);
  res.status(200).json({
    success: true,
    user,
  });
});
exports.updatePassword = catchAsyncError(async (req, res, next) => {
  const user = await User.findById(req.user.id).select("+password");
  const isPasswordMatched = await user.comparePassword(req.body.oldPassword);
  if (!isPasswordMatched) {
    return next(new ErrorHandler("Old Password is Incorrect", 400));
  }
  if (req.body.newPassword !== req.body.confirmPassword) {
    return next(new ErrorHandler("The entered password doesn't match", 400));
  }
  user.password = req.body.newPassword;
  await user.save();
  res.status(200).json({
    success: true,
    user,
  });
  sendToken(user, 200, res);
});
exports.updateProfile = catchAsyncError(async (req, res, next) => {
  const newUserData = {
    name: req.body.name,
    email: req.body.email,
  };
  const user = await User.findByIdAndUpdate(req.user.id, newUserData, {
    new: true,
    runValidators: true,
    useFindAndModify: false,
  });

  sendToken(user, 200, res);
});

exports.updateRoles = catchAsyncError(async (req, res, next) => {
  const newUserData = {
    name: req.body.name,
    email: req.body.email,
    role: req.body.role,
  };
  const user = await User.findByIdAndUpdate(req.user.id, newUserData, {
    new: true,
    runValidators: true,
    useFindAndModify: false,
  });

  res.status(200).json({
    success: true,
    user,
    message: "User Role Updated",
  });
});
exports.deleteProfile = catchAsyncError(async (req, res, next) => {
  const user = await User.findByIdAndDelete(req.params.id);
  if (!user) {
    return next(new ErrorHandler("No User found", 400));
  }
  res.status(200).json({
    success: true,
    user,
    message: "User Deleted Successfully",
  });
});
