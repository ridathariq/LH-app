const Attendance = require("../model/attendance.model");
const User = require("../model/user.model");

// **Mark Attendance for a Room**

exports.markAttendance = async (roomno, attendanceList) => {
  const date = new Date().toISOString().split("T")[0]; // Store date as "YYYY-MM-DD"

  console.log("🔍 Checking attendance for:", { roomno, date });

  let attendanceRecord = await Attendance.findOne({ date, roomno });

  if (!attendanceRecord) {
    // 🔹 Create a new record if it doesn't exist
    attendanceRecord = new Attendance({ date, roomno, students: attendanceList });
  } else {
    // 🔹 Update existing record
    attendanceRecord.students = attendanceList;
  }

  await attendanceRecord.save();
  console.log("✅ Attendance Saved Successfully:", attendanceRecord);
};



// **Get Attendance by Room and Date**
exports.getAttendanceByRoom = async (roomno, date) => {
  return await Attendance.findOne({ roomno, date });
};

// **Fetch Students by Room Number**
exports.getStudentsByRoom = async (roomno) => {
  return await User.find({ roomno: roomno }, "name registernumber");
};


