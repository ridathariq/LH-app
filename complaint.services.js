const Complaint = require("../model/complaint.model");

// **Save Complaint in Database**
exports.createComplaint = async (data) => {
    const complaint = new Complaint(data);
    return await complaint.save();
};

// **Fetch Complaints Based on Role**
exports.getComplaintsForRecipient = async (recipient) => {
    return await Complaint.find({ recipient }).sort({ createdAt: -1 }); // Latest first
};
// **Fetch Complaints for a Specific Student**
exports.getComplaintsByStudent = async (studentRegNo) => {
    return await Complaint.find({ studentRegNo }).sort({ createdAt: -1 });
};
