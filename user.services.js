const User = require("../model/user.model");
const jwt = require("jsonwebtoken");

// **Find user by register number**
exports.checkUser = async (registernumber) => {
    return await User.findOne({ registernumber });
};

// **Generate JWT Token**
exports.generateToken = (userData) => {
    return jwt.sign(userData, "secretKey", { expiresIn: "1h" });
};