const db = require("../config/db");
const redis = require("../config/redis");

const fs = require("fs");

const {
  PutObjectCommand,
  DeleteObjectCommand,
  GetObjectCommand,
} = require("@aws-sdk/client-s3");

const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");

const s3 = require("../config/s3");


// 📤 Upload File → S3 (FIXED)
exports.uploadFile = async (req, res) => {
  try {
    const file = req.file;

    if (!file) {
      return res.status(400).json({ message: "No file uploaded" });
    }

    const cleanName = file.originalname.replace(/\s+/g, "_");
    const key = `uploads/${Date.now()}-${cleanName}`;

    // ✅ IMPORTANT FIX: use file.path
    await s3.send(
      new PutObjectCommand({
        Bucket: process.env.S3_BUCKET,
        Key: key,
        Body: fs.createReadStream(file.path),
        ContentType: file.mimetype || "application/octet-stream",
      })
    );

    console.log("Uploaded:", key);

    // 🧹 delete temp file
    fs.unlinkSync(file.path);

    const fileUrl = `https://${process.env.S3_BUCKET}.s3.${process.env.AWS_REGION}.amazonaws.com/${key}`;

    const result = await db.query(
      "INSERT INTO files(name, url) VALUES($1,$2) RETURNING *",
      [file.originalname, fileUrl]
    );

    await redis.del("files");

    res.json(result.rows[0]);

  } catch (err) {
    console.error("Upload error:", err);
    res.status(500).json({ error: err.message });
  }
};


// 📥 Get Files
exports.getFiles = async (req, res) => {
  try {
    const cached = await redis.get("files");

    if (cached) {
      console.log("⚡ Redis hit");
      return res.json(JSON.parse(cached));
    }

    const result = await db.query("SELECT * FROM files ORDER BY id DESC");

    await redis.set("files", JSON.stringify(result.rows), "EX", 60);

    res.json(result.rows);

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};


// 🗑 Delete File
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

    let key;
    if (file.url.startsWith("http")) {
      key = file.url.split(".amazonaws.com/")[1];
    } else {
      key = file.url;
    }

    await s3.send(
      new DeleteObjectCommand({
        Bucket: process.env.S3_BUCKET,
        Key: key,
      })
    );

    await db.query("DELETE FROM files WHERE id=$1", [id]);
    await redis.del("files");

    res.json({ message: "Deleted successfully" });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};


// 🔐 Secure Download (Pre-signed URL)
exports.getDownloadUrl = async (req, res) => {
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

    const key = file.url.split(".amazonaws.com/")[1];

    const command = new GetObjectCommand({
      Bucket: process.env.S3_BUCKET,
      Key: key,
    });

    const signedUrl = await getSignedUrl(s3, command, {
      expiresIn: 300,
    });

    res.json({ url: signedUrl });

  } catch (err) {
    console.error("Download error:", err);
    res.status(500).json({ error: err.message });
  }
};
