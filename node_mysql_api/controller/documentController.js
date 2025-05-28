const db = require('../db');

// GET /documents
exports.list = async (req, res) => {
  const sql = 'SELECT d_title, d_desc FROM document';
  try {
    const [rows] = await db.execute(sql);
    return res.json(rows);
  } catch (e) {
    console.error(e);
    return res.status(500).json({ error: 'Error fetching documents' });
  }
};

// POST / documents
exports.create = async (req, res) => {
  const { d_typeId, d_title, d_desc } = req.body;
  if (d_typeId == null || d_title == null || d_desc == null) {
    return res
      .status(400)
      .json({ error: 'Not enough field requirement' });
  }

  try {
    const [result] = await db.execute(
    'INSERT INTO document (d_typeId, d_title, d_desc)VALUES (?, ?, ?)',
    [d_typeId, d_title, d_desc]
    );
    // correctly chain .status().json()
    res.status(201).json({
        message: 'Document Created',
        document:{
                id: result.insertId,
                d_typeId,
                d_title,
                d_desc
        }
      });

  } catch (err) {
    console.error(err);

    res
      .status(500)
      .json({ error: 'Error creating document' });
  }
};



exports.add = async (req, res) => {

}
