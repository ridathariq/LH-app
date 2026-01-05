const ComplaintService = require("../services/complaint.services");

// **Submit Complaint**
exports.submitComplaint = async (req, res) => {
    try {
        const { studentRegNo, studentName, recipient, complaintText } = req.body;

        if (!studentRegNo || !studentName || !recipient || !complaintText) {
            return res.status(400).json({ error: "All fields are required" });
        }

        const complaint = await ComplaintService.createComplaint({ 
            studentRegNo, 
            studentName, 
            recipient, 
            complaintText 
        });

        res.status(201).json({ message: "Complaint submitted successfully", complaint });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

// **Get Complaints for Warden/Matron**
exports.getComplaints = async (req, res) => {
    try {
        const { recipient } = req.params; // Get recipient from URL

        if (!["Warden", "Matron"].includes(recipient)) {
            return res.status(400).json({ error: "Invalid recipient" });
        }

        const complaints = await ComplaintService.getComplaintsForRecipient(recipient);
        res.status(200).json(complaints);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

// **Get Complaints by Student Registration Number**
exports.getComplaintsByStudent = async (req, res) => {
    try {
        const { studentRegNo } = req.params;

        if (!studentRegNo) {
            return res.status(400).json({ error: "Student Register Number is required" });
        }

        const complaints = await ComplaintService.getComplaintsByStudent(studentRegNo);

        res.status(200).json(complaints);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};
