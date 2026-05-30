require("dotenv").config();
const express = require("express");
const cors = require("cors");

const fileRoutes = require("./routes/fileRoutes");

const app = express();

app.use(cors({ origin: "*" }));
app.use(express.json({ limit: "50mb" }));
app.use(express.urlencoded({ extended: true }));

// Health / Root Route
app.get("/", (req, res) => {
res.status(200).send("Backend Running");
});

app.use("/api", fileRoutes);

// Start Server
if (require.main === module) {
app.listen(process.env.PORT, () => {
console.log(`🚀 Server running on port ${process.env.PORT}`);
});
}

module.exports = app;
