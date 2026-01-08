const mongoose = require("mongoose");

const OutgoingSchema = new mongoose.Schema({
  registernumber: { type: String, required: true },
  name: { type: String, required: true },
  roomNo: { type: String, required: true },
  place: { type: String, required: true },
  goingTime: { type: String, required: true },
  reachBackTime: { type: String, required: true }
});

module.exports = mongoose.model("Outgoing", OutgoingSchema);
