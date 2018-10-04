var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');
var mongoose = require('mongoose');

let app = express();

mongoose.connect(process.env.MONGODB_URI);

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

let models = require('./models.js');


/* returns the userid */
app.post("/login", (req, res)=> {

  res.json({userid: ""});
});

app.post("/register", (req, res) => {
  res.json({});

});

app.get("/groceryList/:userid", (req,res)=> {
  let userid = req.params.userid;
  res.json({});


});

app.get("/pantry/:userid", (req,res) => {
  let userid = req.params.userid;
  res.json({});
})

app.post("/addItemsToList/:userid", (req, res) => {
  let userid = req.params.userid;
  let items = req.body.items;
  res.json({status: 200});
});

app.post("/addToPantry/:userid",(req, res)=> {
  let userid = req.params.userid;
  let items = req.body.items;
  res.json({status: 200});
})

app.post("/removeFromPantry/:userid",(req, res)=> {
  let userid = req.params.userid;
  let items = req.body.items;
  res.json({status:200});
})

/* from grocery list to pantry */
app.post("/moveItemsToPantry/:userid",(req, res)=> {
  let userid = req.params.userid;
  let items = req.body.items;
  res.json({status: 200});
})
