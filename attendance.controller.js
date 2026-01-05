const AttendanceService = require("../services/attendance.service");
const User = require("../model/user.model");
const Attendance = require("../model/attendance.model"); // Import the Attendance model

// **Fetch Students for a Given Room**
exports.getStudentsByRoom = async (req, res) => {
  try {
    const { roomno } = req.params;
    const students = await AttendanceService.getStudentsByRoom(roomno);

    if (!students.length) {
      return res.status(404).json({ message: "No students found for this room" });
    }

    res.status(200).json(students);
  } catch (error) {
    res.status(500).json({ message: "Server error", error: error.message });
  }
};

// **Mark Attendance for a Room**
exports.markAttendance = async (req, res) => {
  try {
    const { roomno, students } = req.body;

    console.log("🔍 Received Attendance Data:", { roomno, students }); // Debug log

    if (!roomno || !students || !Array.isArray(students)) {
      return res.status(400).json({ message: "Invalid request data" });
    }

    await AttendanceService.markAttendance(roomno, students);
    res.status(200).json({ message: "✅ Attendance marked successfully" });
  } catch (error) {
    console.error("❌ Error marking attendance:", error); // Debug log
    res.status(500).json({ message: "Server error", error: error.message });
  }
};

// **Get Attendance for a Room on a Specific Date**
exports.getAttendanceByRoom = async (req, res) => {
  try {
    const { roomno, date } = req.params;
    const attendance = await AttendanceService.getAttendanceByRoom(roomno, date);

    if (!attendance) {
      return res.status(404).json({ message: "No attendance record found" });
    }

    res.status(200).json(attendance);
  } catch (error) {
    res.status(500).json({ message: "Server error", error: error.message });
  }
};

// **Fetch Unique Room Numbers**
exports.getRooms = async (req, res) => {
  try {
    const rooms = await User.distinct("roomno");
    res.status(200).json(rooms);
  } catch (error) {
    res.status(500).json({ message: "Server error", error: error.message });
  }
};

// **Get Attendance for a Student by Month**
// **Get Attendance for a Student by Month**
// **Get Attendance for a Student by Month**
// **Get Attendance for a Student by Month**
exports.getAttendanceByMonth = async (req, res) => {
  try {
    const { registernumber, year, month } = req.params;

    console.log(`Fetching attendance for: student=${registernumber}, year=${year}, month=${month}`);

    // Convert year & month to integer
    const yearInt = parseInt(year);
    const monthInt = parseInt(month);

    // Format month with leading zero if needed
    const monthFormatted = monthInt.toString().padStart(2, '0');
    
    // Create a regex pattern to match dates in the specified month
    const datePattern = `${yearInt}-${monthFormatted}-`;

    console.log(`Looking for attendance with date pattern: ${datePattern}`);

    // Fetch attendance records for the specific month and student
    const attendanceRecords = await Attendance.find({
      date: { $regex: datePattern },
      "students.registernumber": registernumber
    });

    console.log(`Found ${attendanceRecords.length} attendance records`);

    if (attendanceRecords.length === 0) {
      return res.status(200).json([]); // Return empty array instead of 404
    }

    // Extract attendance data for the specific student
    let attendanceData = attendanceRecords.map(record => {
      const student = record.students.find(s => s.registernumber === registernumber);
      if (student) {
        return {
          date: record.date,
          isPresent: student.isPresent
        };
      }
      return null;
    }).filter(element => element !== null);

    console.log(`Extracted ${attendanceData.length} attendance records for student`);
    
    res.status(200).json(attendanceData);
  } catch (error) {
    console.error("Error fetching attendance by month:", error);
    res.status(500).json({ message: "Server error", error: error.message });
  }
};