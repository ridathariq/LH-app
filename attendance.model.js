const mongoose = require("mongoose");

const AttendanceSchema = new mongoose.Schema({
  date: { type: String, required: true }, // Change Date to String
  roomno: { type: String, required: true },
  students: [
    {
      registernumber: { type: String, required: true },
      name: { type: String, required: true },
      isPresent: { type: Boolean, default: true },
    },
  ],
});

module.exports = mongoose.model("Attendance", AttendanceSchema);
