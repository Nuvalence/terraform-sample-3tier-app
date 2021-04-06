const express = require("express");
const router = express.Router();

// database status sent to client
var databaseConnection = "Waiting for response from MySQL...";


// load sdk and set region
var mysql = require('mysql');

var connection = mysql.createConnection({
    socketPath : '/cloudsql/cwb-ci-bootcamp:us-west2:mysql-cbouscal',
    user : 'cbouscal',
    password : 'billiard. Giraffe',
    database : 'workshop'
});

// test query to table
connection.connect(function (err) {
    if (!err) {
        console.log("Database is connected");
        databaseConnection = "Connected to MySQL";
    } else {
        console.log("Database is not connected" + err);
    }
});

// export router

router.get("/", function(req, res, next) {
    res.send(databaseConnection);
});

// export router
module.exports = router;
