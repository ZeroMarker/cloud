import fs from "node:fs";
import path from "node:path";
import oracledb from "oracledb";

const walletDir = process.env.DB_WALLET_DIR;
const connectString = process.env.DB_DSN;

const requiredEnvironment = [
  "DB_USER",
  "DB_PASSWORD",
  "DB_WALLET_PASSWORD",
  "DB_WALLET_DIR",
  "DB_DSN",
];
const missingEnvironment = requiredEnvironment.filter(
  (name) => !process.env[name],
);

if (missingEnvironment.length > 0) {
  console.error(
    `Missing environment variables: ${missingEnvironment.join(", ")}`,
  );
  process.exit(2);
}

for (const walletFile of ["tnsnames.ora", "ewallet.pem"]) {
  const filePath = path.join(walletDir, walletFile);
  if (!fs.existsSync(filePath)) {
    console.error(`Wallet file not found: ${filePath}`);
    process.exit(2);
  }
}

let pool;

try {
  pool = await oracledb.createPool({
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    connectString,
    configDir: walletDir,
    walletLocation: walletDir,
    walletPassword: process.env.DB_WALLET_PASSWORD,
    poolMin: 0,
    poolMax: 2,
    poolIncrement: 1,
  });

  const connection = await pool.getConnection();
  try {
    const result = await connection.execute(
      `SELECT
         SYS_CONTEXT('USERENV', 'DB_NAME') AS DB_NAME,
         SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') AS CURRENT_SCHEMA,
         SYSTIMESTAMP AS DB_TIME
       FROM dual`,
      [],
      { outFormat: oracledb.OUT_FORMAT_OBJECT },
    );

    console.log("Oracle Autonomous Database connection succeeded.");
    console.table(result.rows);
  } finally {
    await connection.close();
  }
} catch (error) {
  console.error("Oracle connection failed.");
  if (error?.errorNum) console.error(`Oracle error: ORA-${error.errorNum}`);
  console.error(error?.message ?? error);
  process.exitCode = 1;
} finally {
  if (pool) await pool.close(0);
}
