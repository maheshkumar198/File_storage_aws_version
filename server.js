// server.js
require("dotenv").config();
const express = require("express");
const cors = require("cors");
const path = require("path");

const fileRoutes = require("./routes/fileRoutes");

const app = express();

app.use(cors());
app.use(express.json());

// serve local files
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

app.use("/api", fileRoutes);

app.listen(process.env.PORT, () => {
  console.log(`Server running on port ${process.env.PORT}`);
});

