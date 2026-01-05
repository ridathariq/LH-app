const HomegoingService = require("../services/homegoing.services");
const User = require("../model/user.model"); // Import User model

// **Submit Homegoing Request**
// **Submit Homegoing Request**
exports.submitHomegoing = async (req, res) => {
    try {
        const { registernumber, goingDate, comingDate } = req.body;

        if (!registernumber || !goingDate || !comingDate) {
            return res.status(400).json({ error: "Register number, going date, and coming date are required" });
        }

        const student = await User.findOne({ registernumber });

        if (!student) {
            return res.status(404).json({ error: "Student not found" });
        }

        // ✅ Include register number in the request
        const homegoingRequest = await HomegoingService.createHomegoingRequest({
            registernumber, // 🔹 Add register number
            name: student.name,
            place: student.place,
            phoneNumber: student.phno,
            roomNo: student.roomno,
            goingDate,
            comingDate
        });

        res.status(201).json({ message: "Homegoing request submitted successfully", homegoingRequest });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};



// **Get Homegoing Requests**
exports.getHomegoingRequests = async (req, res) => {
    try {
        const homegoingRequests = await HomegoingService.getAllHomegoingRequests();
        res.status(200).json(homegoingRequests);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};
