
const UserService = require("../services/user.services");

exports.login = async (req, res) => {
    try {
        const { registernumber, password } = req.body;
        
        // 1. **Check if user exists**
        const user = await UserService.checkUser(registernumber);
        if (!user) {
            return res.status(401).json({ status: false, error: "User does not exist" });
        }

        // 2. **Check if password is correct**
        const isMatch = await user.comparePassword(password);
        if (!isMatch) {
            return res.status(401).json({ status: false, error: "Incorrect password" });
        }

        // 3. **Generate Token**
        const tokenData = { 
            _id: user._id, 
            registernumber: user.registernumber,
            name: user.name,
            role: user.role
        };
        const token = UserService.generateToken(tokenData);

        // 4. **Send Response**
        res.status(200).json({
            status: true,
            token: token,
            role: user.role,
            message: "Login successful"
        });

    } catch (err) {
        res.status(500).json({ status: false, error: err.message });
    }
};