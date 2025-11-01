const mongoose = require('mongoose');

mongoose.connect('', {
    // useNewUrlParser: true,
    // useUnifiedTopology: true
}).then(() => console.log("MongoDB Connected Successfully"))
.catch(err => console.log("MongoDB Connection Failed", err));


module.exports = mongoose;
