const router = require('express').Router();
const ctrl   = require('../controller/departmentController');

router.get('/department', ctrl.all);

module.exports = router;