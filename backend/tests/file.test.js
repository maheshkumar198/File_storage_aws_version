// 🔐 MOCKS FIRST (IMPORTANT)
jest.mock("../config/db", () => ({
  query: jest.fn(),
}));

jest.mock("../config/redis", () => ({
  get: jest.fn(),
  set: jest.fn(),
  del: jest.fn(),
}));

jest.mock("../config/s3", () => ({
  send: jest.fn(),
}));

jest.mock("@aws-sdk/s3-request-presigner", () => ({
  getSignedUrl: jest.fn().mockResolvedValue("https://signed-url.com"),
}));

const request = require("supertest");
const app = require("../server");

const db = require("../config/db");
const redis = require("../config/redis");
const s3 = require("../config/s3");

describe("File API Tests", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  // =========================
  // 📥 GET FILES
  // =========================

  it("should fetch files from DB (cache miss)", async () => {
    redis.get.mockResolvedValue(null);

    db.query.mockResolvedValue({
      rows: [{ id: 1, name: "test.txt", url: "uploads/test.txt" }],
    });

    const res = await request(app).get("/api/files");

    expect(res.statusCode).toBe(200);
    expect(res.body.length).toBe(1);
    expect(redis.set).toHaveBeenCalled();
  });

  it("should fetch files from Redis (cache hit)", async () => {
    redis.get.mockResolvedValue(JSON.stringify([{ id: 1 }]));

    const res = await request(app).get("/api/files");

    expect(res.statusCode).toBe(200);
    expect(db.query).not.toHaveBeenCalled();
  });

  it("should return 500 if DB fails", async () => {
    redis.get.mockResolvedValue(null);
    db.query.mockRejectedValue(new Error("DB error"));

    const res = await request(app).get("/api/files");

    expect(res.statusCode).toBe(500);
  });

  // =========================
  // 📤 UPLOAD
  // =========================

  it("should return 400 if no file uploaded", async () => {
    const res = await request(app).post("/api/upload");

    expect(res.statusCode).toBe(400);
  });

  it("should upload file successfully", async () => {
    db.query.mockResolvedValue({
      rows: [{ id: 1, name: "test.txt", url: "uploads/test.txt" }],
    });

    const res = await request(app)
      .post("/api/upload")
      .attach("file", Buffer.from("hello"), "test.txt");

    expect(res.statusCode).toBe(200);
    expect(res.body.name).toBe("test.txt");
  });

  it("should return 500 if S3 upload fails", async () => {
    s3.send.mockRejectedValue(new Error("S3 error"));

    const res = await request(app)
      .post("/api/upload")
      .attach("file", Buffer.from("hello"), "test.txt");

    expect(res.statusCode).toBe(500);
  });

  // =========================
  // 🗑 DELETE
  // =========================

// =========================
// 🗑 DELETE
// =========================

it("should delete file successfully", async () => {
  // 1️⃣ First query → SELECT file
  db.query.mockResolvedValueOnce({
    rows: [{ id: 1, url: "uploads/test.txt" }],
  });

  // 2️⃣ Second query → DELETE file
  db.query.mockResolvedValueOnce({
    rowCount: 1,
  });

  // 3️⃣ S3 success
  s3.send.mockResolvedValue({});

  const res = await request(app).delete("/api/files/1");

  expect(res.statusCode).toBe(200);
  expect(res.body.message).toBe("Deleted successfully");
});

it("should return 404 if file not found", async () => {
  // DB returns empty
  db.query.mockResolvedValueOnce({ rows: [] });

  const res = await request(app).delete("/api/files/999");

  expect(res.statusCode).toBe(404);
});
  // =========================
  // 🔐 DOWNLOAD
  // =========================

  it("should return signed URL", async () => {
    db.query.mockResolvedValue({
      rows: [
        {
          id: 1,
          url: "https://bucket.s3.amazonaws.com/uploads/test.txt",
        },
      ],
    });

    const res = await request(app).get("/api/download/1");

    expect(res.statusCode).toBe(200);
    expect(res.body.url).toBe("https://signed-url.com");
  });

  it("should return 404 if download file not found", async () => {
    db.query.mockResolvedValue({ rows: [] });

    const res = await request(app).get("/api/download/999");

    expect(res.statusCode).toBe(404);
  });

  it("should return 500 if signed URL fails", async () => {
    const presigner = require("@aws-sdk/s3-request-presigner");

    db.query.mockResolvedValue({
      rows: [
        {
          id: 1,
          url: "https://bucket.s3.amazonaws.com/uploads/test.txt",
        },
      ],
    });

    presigner.getSignedUrl.mockRejectedValue(new Error("Sign error"));

    const res = await request(app).get("/api/download/1");

    expect(res.statusCode).toBe(500);
  });
});
