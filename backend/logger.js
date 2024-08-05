//logger.js

const winston = require("winston");

// Create a Winston logger instance
const logger = winston.createLogger({
  level: "info", // Minimum level of messages to log
  format: winston.format.combine(
    winston.format.colorize(), // Colorize log messages
    winston.format.timestamp(), // Add a timestamp to each log message
    winston.format.printf(({ timestamp, level, message }) => {
      return `${timestamp} [${level}]: ${message}`; // Format the log message
    })
  ),
  transports: [
    new winston.transports.Console(), // Output logs to the console
    // Optionally, add a file transport to save logs to a file
    // new winston.transports.File({ filename: 'combined.log' })
  ],
});

module.exports = logger;
