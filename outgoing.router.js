const express = require("express");
const Outgoing = require("../model/outgoing.model");
const User = require("../model/user.model"); // Import User Model
const router = express.Router();

// **Submit Outgoing Request**
router.post("/submit", async (req, res) => {
    try {
        const { registernumber, place, goingTime, reachBackTime } = req.body;

        const student = await User.findOne({ registernumber });

        if (!student) {
            return res.status(404).json({ message: "Student not found" });
        }

        const newRequest = new Outgoing({
            registernumber,
            name: student.name,
            roomNo: student.roomno,
            place,
            goingTime,
            reachBackTime
        });

        await newRequest.save();
        console.log("✅ Request Saved:", newRequest); // Log saved data

        res.status(201).json({ message: "Outgoing request submitted successfully" });
    } catch (error) {
        console.error("❌ Error Saving Request:", error.message);
        res.status(500).json({ message: "Server error", error: error.message });
    }
});

// **Fetch Student Details by Register Number**
router.get("/student-details/:registernumber", async (req, res) => {
    try {
        const student = await User.findOne({ registernumber: req.params.registernumber });

        if (!student) {
            return res.status(404).json({ message: "Student not found" });
        }

        res.status(200).json({
            name: student.name,
            roomno: student.roomno
        });
    } catch (error) {
        res.status(500).json({ message: "Server error", error: error.message });
    }
});

// **Fetch Outgoing Requests by Register Number**
router.get("/requests/:registernumber", async (req, res) => {
    try {
        const { registernumber } = req.params;
        const requests = await Outgoing.find({ registernumber });

        if (!requests.length) {
            return res.status(200).json([]); // Return empty array if no requests found
        }

        res.status(200).json(requests);
    } catch (error) {
        res.status(500).json({ message: "Server error", error: error.message });
    }
});
router.get("/requests", async (req, res) => {
    try {
        const requests = await Outgoing.find(); // Get all requests
        res.status(200).json(requests);
    } catch (error) {
        res.status(500).json({ message: "Server error", error: error.message });
    }
});

module.exports = router;
