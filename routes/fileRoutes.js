const express = require("express");
const multer = require("multer");

const {
  uploadFile,
  getFiles,
  deleteFile,
  getDownloadUrl,
} = require("../controllers/fileController");

const router = express.Router();

// ✅ Disk storage (temporary faster fix)
const upload = multer({
  dest: "uploads/",
  limits: { fileSize: 50 * 1024 * 1024 }, // 50MB
});

router.post("/upload", upload.single("file"), uploadFile);
router.get("/files", getFiles);
router.delete("/files/:id", deleteFile);
router.get("/download/:id", getDownloadUrl);

module.exports = router;
