const { connect } = require("mongoose");
const app = require("./app");
const dotenv = require("dotenv");
const connectDatabase = require("./config/database");

//handling uncaught exception
process.on("uncaughtException", (err) => {
  console.log(`Error:${err.message}`);
  console.log("Shutting Down Server due to Unhandled Exception");
  process.exit(1);
});
//config file import for PORT
dotenv.config({ path: "config/config.env" });

//connecting with database

connectDatabase();
const server = app.listen(process.env.PORT, () => {
  console.log(`Server is working on ${process.env.PORT} `);
});

//Unhandled Promise Rejection
process.on("unhandledRejection", (err) => {
  console.log(`Error:${err.message}`);
  console.log("Shutting Down Server due to Unhandled Promise Rejection");
  server.close(() => {
    process.exit(1);
  });
});
