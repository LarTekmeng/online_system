const db = require('../db');

// GET /employees
exports.list = async (req, res) => {
  try {
    const rows = await db.any('SELECT * FROM employee');
    res.json(rows);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Error fetching employees' });
  }
};

// GET /employees/:id
exports.getById = async (req, res) => {
  const { id } = req.params;

  try {
    const employee = await db.oneOrNone(
      `SELECT e.id, e.employee_name, e.email, e.dp_id, d.name AS dp_name
       FROM employee e
       LEFT JOIN department d ON e.dp_id = d.id
       WHERE e.id = $1`,
      [id]
    );

    if (!employee) {
      return res.status(404).json({ error: 'Employee not found' });
    }

    res.json({ employee });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
};
