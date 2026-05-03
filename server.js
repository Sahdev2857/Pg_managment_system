require("dotenv").config();
const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
  });

// ROUTES (define BEFORE starting server)

app.get("/test", (req, res) => {
  res.send("Server working");
});

app.get("/tenants", (req, res) => {
  console.log("➡️ Request hit /tenants");

  db.query("SELECT * FROM Tenant", (err, result) => {
    if (err) {
      console.error("❌ DB Error:", err);
      return res.status(500).send(err);
    }

    console.log("✅ Sending response");
    res.json(result);
  });
});

app.post("/tenant", (req, res) => {
  const { name, phone, room } = req.body;

  db.query(
    "INSERT INTO Tenant (Name, Phone, Gender, ID_Proof, Joining_Date, ROOM_ID) VALUES (?,?,?,?,?,?)",
    [name, phone, "Male", "Aadhar", "2024-01-01", room],
    (err) => {
      if (err) return res.status(500).send(err);
      res.send("Added");
    }
  );
});

app.get("/rooms/available", (req, res) => {
  const query = `
    SELECT r.ROOM_ID, r.Room_Number, r.Capacity,
           COUNT(t.Tenant_ID) AS occupied
    FROM Room r
    LEFT JOIN Tenant t ON r.ROOM_ID = t.ROOM_ID
    GROUP BY r.ROOM_ID
    HAVING occupied < r.Capacity
  `;

  db.query(query, (err, result) => {
    if (err) return res.status(500).send(err);
    res.json(result);
  });
});

// START SERVER ONLY AFTER DB CONNECTS

db.connect(err => {
  if (err) {
    console.error("DB ERROR:", err);
    process.exit(1);
  }

  console.log("Connected to MySQL");

  app.listen(3000, () => {
    console.log("Server running on port 3000");
  });
});