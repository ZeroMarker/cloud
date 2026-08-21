import fs from "node:fs";
import path from "node:path";
import oracledb from "oracledb";

const walletDir = process.env.DB_WALLET_DIR;
const connectString = process.env.DB_DSN;
const appUser = (process.env.APP_DB_USER ?? "APP_USER").toUpperCase();
const appPassword = process.env.APP_DB_PASSWORD;

const requiredEnvironment = [
  "DB_USER",
  "DB_PASSWORD",
  "DB_WALLET_PASSWORD",
  "DB_WALLET_DIR",
  "DB_DSN",
  "APP_DB_PASSWORD",
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

if (!/^[A-Z][A-Z0-9_]{0,29}$/.test(appUser)) {
  console.error(
    "APP_DB_USER must start with a letter and contain only A-Z, 0-9, or underscore (maximum 30 characters).",
  );
  process.exit(2);
}

if (
  appPassword.length < 12 ||
  !/[A-Z]/.test(appPassword) ||
  !/[a-z]/.test(appPassword) ||
  !/[0-9]/.test(appPassword) ||
  appPassword.includes('"')
) {
  console.error(
    'APP_DB_PASSWORD must be at least 12 characters and include uppercase, lowercase, and a number; it cannot contain ".',
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

const quotedUser = `"${appUser}"`;
const quotedPassword = `"${appPassword}"`;
let adminConnection;

try {
  adminConnection = await oracledb.getConnection({
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    connectString,
    configDir: walletDir,
    walletLocation: walletDir,
    walletPassword: process.env.DB_WALLET_PASSWORD,
  });

  const existing = await adminConnection.execute(
    "SELECT username FROM dba_users WHERE username = :username",
    { username: appUser },
  );

  if (existing.rows.length > 0) {
    console.error(`Database user ${appUser} already exists; no changes made.`);
    process.exitCode = 3;
  } else {
    await adminConnection.execute(
      `CREATE USER ${quotedUser}
         IDENTIFIED BY ${quotedPassword}
         DEFAULT TABLESPACE DATA
         TEMPORARY TABLESPACE TEMP
         QUOTA 200M ON DATA`,
    );
    await adminConnection.execute(
      `GRANT CREATE SESSION,
             CREATE TABLE,
             CREATE VIEW,
             CREATE SEQUENCE,
             CREATE PROCEDURE,
             CREATE TRIGGER
         TO ${quotedUser}`,
    );

    const verification = await adminConnection.execute(
      `SELECT username, account_status, default_tablespace, temporary_tablespace
         FROM dba_users
        WHERE username = :username`,
      { username: appUser },
      { outFormat: oracledb.OUT_FORMAT_OBJECT },
    );

    console.log(`Database user ${appUser} created successfully.`);
    console.table(verification.rows);

    const appConnection = await oracledb.getConnection({
      user: appUser,
      password: appPassword,
      connectString,
      configDir: walletDir,
      walletLocation: walletDir,
      walletPassword: process.env.DB_WALLET_PASSWORD,
    });
    try {
      const loginCheck = await appConnection.execute(
        "SELECT SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') AS CURRENT_SCHEMA FROM dual",
        [],
        { outFormat: oracledb.OUT_FORMAT_OBJECT },
      );
      console.log("Application user login succeeded.");
      console.table(loginCheck.rows);
    } finally {
      await appConnection.close();
    }
  }
} catch (error) {
  console.error(`Failed to create database user ${appUser}.`);
  if (error?.errorNum) console.error(`Oracle error: ORA-${error.errorNum}`);
  console.error(error?.message ?? error);
  process.exitCode = 1;
} finally {
  if (adminConnection) await adminConnection.close();
}
