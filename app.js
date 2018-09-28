var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');
var mongoose = require('mongoose');

let app = express();

mongoose.connect(process.env.MONGODB_URI);

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));


app.post("/login", (req, res)=> {
  res.json({});
});

app.post("/register", (req, res)=> {
  res.json({});

});

app.get("/getGroceryList/:userid", (req,res)=> {
  let userid = req.params.userid;
  res.json({});


});

app.get("/getPantry/:userid", (req,res){
  let userid = req.params.userid;
  res.json({});


});

app.post("/addToPantry/:userid",(req, res)=> {
  let userid = req.params.userid;
  let newItems = req.body.newItems;
  res.json({});

})

app.post("/removeFromPantry/:userid",(req, res)=> {
  let userid = req.params.userid;
  let removeItems = req.body.removeItems;
  res.json({});

})

app.post("/addToGroceryList/:userid",(req, res)=> {
  let userid = req.params.userid;
  let newItems = req.body.newItems;
  res.json({});

})

app.post("/removeFromGroceryList/:userid",(req, res)=> {
  let userid = req.params.userid;
  let removeItems = req.body.removeItems;
  res.json({});

})
