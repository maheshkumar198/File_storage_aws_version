require("dotenv").config();

const { Client } = require("pg");
const { Signer } = require("@aws-sdk/rds-signer");

async function getClient() {
  const signer = new Signer({
    region: process.env.AWS_REGION,
    hostname: process.env.DB_HOST,
    port: 5432,
    username: process.env.DB_USER,
  });

  // 🔥 generate correct IAM token
  const token = await signer.getAuthToken();

  const client = new Client({
    host: process.env.DB_HOST,
    port: 5432,
    database: process.env.DB_NAME,
    user: process.env.DB_USER,
    password: token,
    ssl: {
      rejectUnauthorized: false,
    },
  });

  await client.connect();
  return client;
}

module.exports = getClient;
