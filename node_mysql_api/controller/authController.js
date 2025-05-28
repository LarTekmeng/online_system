// controllers/authController.js
const bcrypt = require('bcrypt');
const db     = require('../db');

exports.register = async (req, res) => {
  const { employee_name, email, password } = req.body;
  if (!employee_name || !email || !password) {
    return res.status(400).json({ error: 'Missing fields' });
  }

  try {
    const hash = await bcrypt.hash(password, 10);
    const [result] = await db.execute(
      'INSERT INTO employee (employee_name, email, password) VALUES (?, ?, ?)',
      [employee_name, email, hash]
    );
    res.status(201).json({
    message: 'Registered successfully',
    employee: {
        id: result.insertId,
        employee_name,
        email,
    }
    });
  } catch (e) {
    if (e.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({ error: 'Email already in use' });
    }
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
};

exports.login = async (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    return res.status(400).json({ error: 'Missing fields' });
  }

  try {
    const [rows] = await db.execute('SELECT * FROM employee WHERE email = ?', [email]);
    if (!rows.length) {
      return res.status(401).json({ error: 'Invalid email or password' });
    }

    const employee = rows[0];
    const match = await bcrypt.compare(password, employee.password);
    if (!match) {
      return res.status(401).json({ error: 'Invalid email or password' });
    }

    res.json({
      message: 'Login successful',
      employee: {
        id:            employee.id,
        employee_name: employee.employee_name,
        email:         employee.email
      }
    });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
};
