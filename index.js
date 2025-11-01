const app = require('./app');
const mongoose = require('./config/db');  // Ensure DB connection
const port = 3000;

app.get('/', (req, res) => {
    res.send("hello world");
});

app.listen(port, () => {
    console.log(`Server listening on http://localhost:${port}`);
});
