const express = require("express");
const AttendanceController = require("../controller/attendance.controller");

const router = express.Router();

// **Fetch all room numbers**
router.get("/rooms", AttendanceController.getRooms);

// **Fetch students by room**
router.get("/students/:roomno", AttendanceController.getStudentsByRoom);

// **Mark attendance**
router.post("/mark", AttendanceController.markAttendance);

// **Get attendance by room and date**
router.get("/:roomno/:date", AttendanceController.getAttendanceByRoom);

// **Get attendance by student and month** - FIXED ROUTE
router.get("/student/:registernumber/:year/:month", AttendanceController.getAttendanceByMonth);

module.exports = router;