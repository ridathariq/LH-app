const router = require('express').Router();
const UserController = require("../controller/user.controller.js"); // Fixed path

router.post('/Login', UserController.login);

module.exports = router;
