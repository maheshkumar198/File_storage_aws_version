const express = require("express");
const multer = require("multer");

const {
  uploadFile,
  getFiles,
  deleteFile,
  trackDownload
} = require("../controllers/fileController");

const router = express.Router();

const upload = multer({
  storage: multer.memoryStorage(),
  limits: {
    fileSize: 50 * 1024 * 1024, // 50MB
  },
});

router.post("/upload", upload.single("file"), uploadFile);
router.get("/files", getFiles);
router.delete("/files/:id", deleteFile);
router.post("/download/:id", trackDownload);

module.exports = router;
