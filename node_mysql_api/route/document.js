const router = require('express').Route();
const ctrl = require('../controller/documentController');

router.get('list', ctrl.list);