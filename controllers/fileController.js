const db = require("../config/db");
const redis = require("../config/redis");

const { PutObjectCommand, DeleteObjectCommand } = require("@aws-sdk/client-s3");
const s3 = require("../config/s3");


// 📤 Upload File → S3
exports.uploadFile = async (req, res) => {
  try {
    const file = req.file;

    if (!file) {
      return res.status(400).json({ message: "No file uploaded" });
    }

    // 🔥 clean filename
    const cleanName = file.originalname.replace(/\s+/g, "_");

    const key = `uploads/${Date.now()}-${cleanName}`;

    // upload to S3
    await s3.send(
      new PutObjectCommand({
        Bucket: process.env.S3_BUCKET,
        Key: key,
        Body: file.buffer,
        ContentType: file.mimetype || "application/octet-stream",
      })
    );

    console.log("Uploaded to S3:", key);

    // ✅ FULL S3 URL (IMPORTANT FIX)
    const fileUrl = `https://${process.env.S3_BUCKET}.s3.${process.env.AWS_REGION}.amazonaws.com/${key}`;

    const result = await db.query(
      "INSERT INTO files(name, url) VALUES($1,$2) RETURNING *",
      [file.originalname, fileUrl]
    );

    // clear cache
    await redis.del("files");

    res.json(result.rows[0]);

  } catch (err) {
    console.error("Upload error:", err);
    res.status(500).json({ error: err.message });
  }
};


// 📥 Get Files (Redis + DB)
exports.getFiles = async (req, res) => {
  try {
    const cached = await redis.get("files");

    if (cached) {
      console.log("⚡ Redis hit");
      return res.json(JSON.parse(cached));
    }

    console.log("🐢 DB hit");

    const result = await db.query("SELECT * FROM files ORDER BY id DESC");

    await redis.set("files", JSON.stringify(result.rows), "EX", 60);

    res.json(result.rows);

  } catch (err) {
    console.error("Fetch error:", err);
    res.status(500).json({ error: err.message });
  }
};


// 🗑️ Delete File → S3
exports.deleteFile = async (req, res) => {
  try {
    const { id } = req.params;

    const result = await db.query(
      "SELECT * FROM files WHERE id=$1",
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: "File not found" });
    }

    const file = result.rows[0];

    // 🔥 extract key from FULL URL
    const key = file.url.split(".amazonaws.com/")[1];

    // delete from S3
    await s3.send(
      new DeleteObjectCommand({
        Bucket: process.env.S3_BUCKET,
        Key: key,
      })
    );

    console.log("Deleted from S3:", key);

    // delete from DB
    await db.query("DELETE FROM files WHERE id=$1", [id]);

    // clear cache
    await redis.del("files");

    res.json({ message: "Deleted successfully" });

  } catch (err) {
    console.error("Delete error:", err);
    res.status(500).json({ error: err.message });
  }
};


// 📊 Track Download
exports.trackDownload = async (req, res) => {
  try {
    const { id } = req.params;

    await redis.incr(`file:${id}:downloads`);

    res.json({ message: "Download tracked" });

  } catch (err) {
    console.error("Tracking error:", err);
    res.status(500).json({ error: err.message });
  }
};
