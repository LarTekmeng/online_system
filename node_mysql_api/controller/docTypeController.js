// controllers/docTypeController.js
const db = require('../db');

exports.create = async (req, res) => {
  const { doc_title, doc_desc } = req.body;
  if (!doc_title || !doc_desc) {
    return res.status(400).json({ error: 'Missing fields' });
  }
  try {
    const [result] = await db.execute(
      'INSERT INTO doc_type (doc_title, doc_desc) VALUES (?, ?)',
      [doc_title, doc_desc]
    );
    res.status(201).json({ message: 'Document type created', id: result.insertId });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
};

exports.list = async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM doc_type');
    res.json(rows);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Error fetching document types' });
  }
};

exports.delete = async (req, res) => {
  const { id } = req.params;              // 1) pull the id from the URL
  try {
    const [result] = await db.execute(
      'DELETE FROM doc_type WHERE id = ?',
      [id]                                 // 2) pass it into the query
    );

    if (result.affectedRows === 0) {      // 3) nothing was deleted?
      return res.status(404).json({ error: 'Document type not found' });
    }

    // 4) success
    res.status(200).json({
      message: 'Document type deleted',
      id:      Number(id),                // echo back the id you deleted
    });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
};

exports.update = async (req, res) => {
  const { id } = req.params;
  const { doc_title, doc_desc } = req.body;

  // Validate
  if (!doc_title || !doc_desc) {
    return res.status(400).json({ error: 'Missing fields' });
  }

  try {
    const [result] = await db.execute(
      'UPDATE doc_type SET doc_title = ?, doc_desc = ? WHERE id = ?',
      [doc_title, doc_desc, id]       // ◀️ pass ALL three parameters
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Document type not found' });
    }

    res.status(200).json({
      message: 'Document type updated',
      id:      Number(id),
    });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
};


