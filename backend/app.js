//import express and export it as the express function
const express = require("express");
const app = express();
const cookieParser = require("cookie-parser");
app.use(express.json());
app.use(cookieParser());

//Route Imports

module.exports = app;
