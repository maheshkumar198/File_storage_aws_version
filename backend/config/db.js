require("dotenv").config();

const { Client } = require("pg");
const { Signer } = require("@aws-sdk/rds-signer");

async function query(text, params) {
  const signer = new Signer({
    region: process.env.AWS_REGION,
    hostname: process.env.DB_HOST,
    port: 5432,
    username: process.env.DB_USER,
  });

  const token = await signer.getAuthToken();

  const client = new Client({
    host: process.env.DB_HOST,
    port: 5432,
    database: process.env.DB_NAME,
    user: process.env.DB_USER,
    password: token,
    ssl: { rejectUnauthorized: false },
  });

  await client.connect();

  const res = await client.query(text, params);

  await client.end();

  return res;
}

module.exports = { query };
