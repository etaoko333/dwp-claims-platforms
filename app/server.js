const express = require("express");
const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

app.get("/health", (req, res) => {
  res.status(200).json({ status: "ok", service: "claims-api" });
});

app.get("/claims", (req, res) => {
  res.status(200).json([
    { id: 1, status: "approved", amount: 100 },
    { id: 2, status: "pending", amount: 250 }
  ]);
});

app.listen(port, () => {
  console.log(`Claims API listening on port ${port}`);
});
