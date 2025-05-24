// controllers/employeeController.js
const db = require('../db');

exports.list = async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM employee');
    res.json(rows);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Error fetching employees' });
  }
};

exports.getById = async (req, res) => {
  const { id } = req.params;
  try {
    const [rows] = await db.execute(
      `SELECT e.id, e.employee_name, e.email, e.dp_id, d.dp_name
       FROM employee e
       LEFT JOIN department d ON e.dp_id = d.id
       WHERE e.id = ?`,
      [id]
    );
    if (!rows.length) {
      return res.status(404).json({ error: 'Employee not found' });
    }
    res.json({ employee: rows[0] });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
};
