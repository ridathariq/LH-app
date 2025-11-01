const Homegoing = require("../model/homegoing.model");

// **Save Homegoing Request in Database**
exports.createHomegoingRequest = async (data) => {
    const homegoingRequest = new Homegoing(data);
    return await homegoingRequest.save();
};

// **Fetch All Homegoing Requests**
exports.getAllHomegoingRequests = async () => {
    return await Homegoing.find().sort({ createdAt: -1 }); // Latest first
};
