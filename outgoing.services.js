const Outgoing = require("../model/outgoing.model");

// **Save Outgoing Request in Database**
exports.createOutgoingRequest = async (data) => {
    const outgoingRequest = new Outgoing(data);
    return await outgoingRequest.save();
};

// **Fetch All Outgoing Requests**
exports.getAllOutgoingRequests = async () => {
    return await Outgoing.find().sort({ createdAt: -1 }); // Latest first
};
