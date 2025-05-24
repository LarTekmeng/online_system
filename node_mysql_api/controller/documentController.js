const db = require('../db');

exports.list = async (req, res) => {
    const { d_title, d_desc } = req.body;
    if (!d_title || !d_desc){
        return res.status(400).json({ error: 'Missing Field'});
    }
    const sql = 'SELECT * FROM document';
    try{
        const [rows] = await db.execute{sql};
        res.json(rows);
    }
    catch (e){
        console.error(e);
        res.status(500).json({ error:'Error Fetching Document'});
    }
}