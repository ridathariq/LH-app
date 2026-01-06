const OutgoingService = require("../services/outgoing.services");
const User = require("../model/user.model"); // Import User model

// **Submit Outgoing Request**
exports.submitOutgoing = async (req, res) => {
    try {
        const { registernumber, place, goingTime, reachBackTime } = req.body;

        if (!registernumber || !place || !goingTime || !reachBackTime) {
            return res.status(400).json({ error: "Register number, place, going time, and reach back time are required" });
        }

        const student = await User.findOne({ registernumber });

        if (!student) {
            return res.status(404).json({ error: "Student not found" });
        }

        // ✅ Include register number, name, and room number in the request
        const outgoingRequest = await OutgoingService.createOutgoingRequest({
            registernumber,
            name: student.name,
            roomNo: student.roomno,
            place,
            goingTime,
            reachBackTime
        });

        res.status(201).json({ message: "Outgoing request submitted successfully", outgoingRequest });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

// **Get Outgoing Requests**
exports.getOutgoingRequests = async (req, res) => {
    try {
        const outgoingRequests = await OutgoingService.getAllOutgoingRequests();
        res.status(200).json(outgoingRequests);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};
