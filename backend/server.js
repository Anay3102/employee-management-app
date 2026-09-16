const express = require("express");
const cors = require("cors");
require("dotenv").config();

const employeeRoutes = require("./routes/employeeRoutes");

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Employee routes
app.use("/api/employees", employeeRoutes);

// Home route
app.get("/", (req, res) => {
    res.json({
        message: "Employee Management API is running"
    });
});

// Server
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});