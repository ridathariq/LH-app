const mongoose = require("mongoose");

const complaintSchema = new mongoose.Schema({
    studentRegNo: { type: String, required: true }, // Register number of the student
    studentName: { type: String, required: true }, // Student name
    recipient: { type: String, enum: ["Warden", "Matron"], required: true }, // Who should receive it
    complaintText: { type: String, required: true }, // Complaint content
    status: { type: String, enum: ["Pending", "Resolved"], default: "Pending" }, // Complaint status
    createdAt: { type: Date, default: Date.now } // Timestamp
});

const Complaint = mongoose.model("Complaint", complaintSchema);
module.exports = Complaint;
