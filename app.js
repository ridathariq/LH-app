const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('./config/db');
const userRouter = require('./routers/user.routers');
const complaintRouter = require('./routers/complaint.router'); // Include complaint routes
const homegoingRouter = require('./routers/homegoing.router'); // Include homegoing routes
const outgoingRouter = require('./routers/outgoing.router'); // Include outgoing routes
const attendanceRouter = require("./routers/attendance.router");

const app = express();
app.use(bodyParser.json());

app.use('/', userRouter);
app.use('/complaints', complaintRouter); // Add complaints route
app.use('/homegoing', homegoingRouter); // Add homegoing route
app.use('/outgoing', outgoingRouter); // Add outgoing route


app.use("/attendance", attendanceRouter);


module.exports = app;
