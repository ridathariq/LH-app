const mongoose = require("mongoose");

const HomegoingSchema = new mongoose.Schema({
  registernumber: { type: String, required: true },
  name: { type: String, required: true },
  roomNo: { type: String, required: true },
  goingDate: { type: String, required: true },
  comingDate: { type: String, required: true },
  place: { type: String, required: true },
  phoneNumber: { type: String, required: true }
});

module.exports = mongoose.model("Homegoing", HomegoingSchema);
