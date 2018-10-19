var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');
var mongoose = require('mongoose');

let app = express();
app.listen(8888);

mongoose.connect(process.env.MONGODB_URI);

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

let User = require('./models.js').User;


/* returns the userid
{
input:
username: username,
password: password 

output:
{
userid: userid
}}*/
app.post("/login", (req, res)=> {
  let username = req.body.username;
  let password = req.body.password;

  User.findOne({
    username: username,
    password: password
  }).then (result => {
    res.json({userid: result._id});
  }).catch(err => {
    res.sendStatus(400).json({error: err});
  })
});


/* input: {
username: username,
password: password }

output
{
status: 200
}*/
app.post("/register", (req, res) => {
  let username = req.body.username;
  let password = req.body.password;

//if this username is taken
  User.findOne ({username: username})
  .then(result => {
    console.log("username taken");
    res.json({status: 400});
  }).catch(err=> {
    //add the user
    let newUser = new User({
      username: username,
      password: password
    });
    newUser.save()
    .then(()=> {
      res.sendStatus(200);
    })
    .catch(err=> {
      console.log("problem saving user");
      res.sendStatus(400).json({error:err});
    })
  })
});

app.get("/groceryList/:userid", (req,res)=> {
  let userid = req.params.userid;
  User.findById(userid)
  .then(result => {
    res.json({groceryList: result.groceryList});
  })
  .catch(err => {
    res.sendStatus(400).json({error: err});
  })
});

app.get("/pantry/:userid", (req,res) => {
  let userid = req.params.userid;
  User.findById(userid)
  .then(result => {
    res.json({pantry: result.pantry})
  })
  .catch(err => {
    res.sendStatus(400).json({error: err});
  })
})

app.post("/addItemsToList/:userid", (req, res) => {
  let userid = req.params.userid;
  let items = req.body.items;

  User.findById(userid)
  .then(user => {
    items.forEach(item=> {
      user.groceryList.push(item);
    })
    res.sendStatus(200);
  })
  .catch(err=> {
    res.sendStatus(400).json({error: err});
  })

});

app.post("/addToPantry/:userid",(req, res)=> {
  let userid = req.params.userid;
  let items = req.body.items;

  User.findById(userid)
  .then(user => {
    items.forEach(item => {
      let newItem = {
        itemName: item,
        daysSincePurchase: 0
      }
      user.pantry.push(newItem);
    })
    res.sendStatus(200);
  })
  .catch(err=> {
    res.sendStatus(400).json({error: err});
  })
})

app.post("/removeFromPantry/:userid",(req, res)=> {
  let userid = req.params.userid;
  let items = req.body.items;

  User.findbyId(userid)
  .then(result => {
    let pantry = result.pantry;
    for (let i=0; i<items.length; i++){
      for (let j=0;j<pantry.length; j++){
        if (pantry[j].itemName === items[i]){
          pantry.splice(j, 1);
        }
      }
    }
    res.sendStatus(200);
  })
  .catch(err=> {
    res.sendStatus(400).json({error: err});
  })
})

/* from grocery list to pantry */
app.post("/moveItemsToPantry/:userid",(req, res)=> {
  let userid = req.params.userid;
  let items = req.body.items;

  User.findById(userid)
  .then(result=> {
    let groceryList = result.groceryList;
    groceryList = groceryList.concat(items);
    res.sendStatus(200);
  })
  .catch(err=> {
    res.sendStatus(400).json({error: err});
  })
})
