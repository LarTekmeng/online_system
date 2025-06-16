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
exports.getByEmployeeId = async (req, res) => {
  const { employeeId } = req.params;
  try {
    const employee = await db.oneOrNone(
      `SELECT e.employee_name, e.email, e.dp_id, e.em_id, d.name AS dp_name
       FROM employee e
       LEFT JOIN department d ON e.dp_id = d.id
       WHERE e.em_id = $1`,
      [employeeId]
    );

    res.json({ employee });

    if (!employee) {
      return res.status(404).json({ error: 'Employee not found' });
    }

    res.json({ employee });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
};
