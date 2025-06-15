/* This is Route*/

const router = require('express').Router();
const ctrl   = require('../controller/departmentController');

router.get('/', ctrl.all);

module.exports = router;