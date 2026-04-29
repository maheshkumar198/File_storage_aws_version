require("dotenv").config();
const express = require("express");
const cors = require("cors");

const fileRoutes = require("./routes/fileRoutes");

const app = express();

app.use(cors());
app.use(express.json());

app.use("/api", fileRoutes);

app.listen(process.env.PORT, () => {
  console.log(`Server running on port ${process.env.PORT}`);
});
