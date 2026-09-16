const db = require("../config/db");

// GET all employees
exports.getEmployees = (req, res) => {
    const sql = "SELECT * FROM employees";

    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({
                error: err.message
            });
        }

        res.json(results);
    });
};


// GET employee by ID
exports.getEmployeeById = (req, res) => {
    const { id } = req.params;

    const sql = "SELECT * FROM employees WHERE id = ?";

    db.query(sql, [id], (err, results) => {
        if (err) {
            return res.status(500).json({
                error: err.message
            });
        }

        if (results.length === 0) {
            return res.status(404).json({
                message: "Employee not found"
            });
        }

        res.json(results[0]);
    });
};


// CREATE employee
exports.createEmployee = (req, res) => {
    const {
        name,
        email,
        department,
        salary
    } = req.body;

    if (!name || !email) {
        return res.status(400).json({
            message: "Name and email are required"
        });
    }

    const sql = `
        INSERT INTO employees
        (name, email, department, salary)
        VALUES (?, ?, ?, ?)
    `;

    const values = [
        name,
        email,
        department,
        salary
    ];

    db.query(sql, values, (err, result) => {
        if (err) {
            return res.status(500).json({
                error: err.message
            });
        }

        res.status(201).json({
            message: "Employee created successfully",
            employeeId: result.insertId
        });
    });
};


// UPDATE employee
exports.updateEmployee = (req, res) => {
    const { id } = req.params;

    const {
        name,
        email,
        department,
        salary
    } = req.body;

    const sql = `
        UPDATE employees
        SET
            name = ?,
            email = ?,
            department = ?,
            salary = ?
        WHERE id = ?
    `;

    const values = [
        name,
        email,
        department,
        salary,
        id
    ];

    db.query(sql, values, (err, result) => {
        if (err) {
            return res.status(500).json({
                error: err.message
            });
        }

        if (result.affectedRows === 0) {
            return res.status(404).json({
                message: "Employee not found"
            });
        }

        res.json({
            message: "Employee updated successfully"
        });
    });
};


// DELETE employee
exports.deleteEmployee = (req, res) => {
    const { id } = req.params;

    const sql = "DELETE FROM employees WHERE id = ?";

    db.query(sql, [id], (err, result) => {
        if (err) {
            return res.status(500).json({
                error: err.message
            });
        }

        if (result.affectedRows === 0) {
            return res.status(404).json({
                message: "Employee not found"
            });
        }

        res.json({
            message: "Employee deleted successfully"
        });
    });
};