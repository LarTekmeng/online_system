const bcrypt = require('bcrypt');
const db     = require('../db');

exports.register = async (req, res) => {
  const { employee_name, email, password, dp_id, em_id } = req.body;
  if (!employee_name || !email || !password || !dp_id || !em_id) {
    return res.status(400).json({ error: 'Missing fields' });
  }

  try {
    const hash = await bcrypt.hash(password, 10);

    const result = await db.one(
      `INSERT INTO employee (employee_name, email, password, dp_id, em_id)
       VALUES ($1, $2, $3, $4, $5)
       RETURNING id`,
      [employee_name, email, dp_id, em_id, hash]
    );

    res.status(201).json({
      message: 'Registered successfully',
      employee: {
        id: result.id,
        employee_name,
        email,
        dp_id,
        em_id,
      }
    });
  } catch (e) {
    if (e.code === '23505') { // PostgreSQL duplicate key
      return res.status(409).json({ error: 'Email already in use' });
    }
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
};

exports.login = async (req, res) => {
  const { em_id, password } = req.body;
  if (!em_id || !password) {
    return res.status(400).json({ error: 'Missing fields' });
  }

  try {
    const employee = await db.oneOrNone(
      `SELECT * FROM employee WHERE em_id = $1`,
      [em_id]
    );

    if (!employee) {
      return res.status(401).json({ error: 'Invalid Employee id or password' });
    }

    const match = await bcrypt.compare(password, employee.password);
    if (!match) {
      return res.status(401).json({ error: 'Invalid Employee id or password' });
    }

    res.json({
      message: 'Login successful',
      employee: {
        id:            employee.id,
        employee_name: employee.employee_name,
        email:         employee.email,
        dp_id:         employee.dp_id,
        em_id:         employee.em_id,
      }
    });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
};
