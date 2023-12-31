//import express and export it as the express function
const express = require("express");
const app = express();
const cookieParser = require("cookie-parser");
const errorMiddleware = require("./middleware/error");
const user = require("./routes/userRoutes");
const parking=require("./routes/parkingRoutes")
app.use(express.json());
app.use(cookieParser());

app.use("/user", user);
app.use("/parking",parking)
app.use(errorMiddleware);

//Route Imports

module.exports = app;
