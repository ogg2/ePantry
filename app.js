var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');
var mongoose = require('mongoose');

let app = express();
app.listen(process.env.PORT || 8888);

mongoose.connect(process.env.MONGODB_URI);

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

let User = require('./models.js').User;
// User.createIndex( "username: 1", { unique: true } );

/* returns the userid
{
input:
username: username,
password: password 

output:
{
userid: userid
}}*/

app.get("/", (req, res)=> {
  res.send("Welcome to ePantry backend");
})

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
User.findOne({username: username})
.then(result=> {
  if (!result){
    let newUser = new User({
      username: username,
      password: password
    });
    newUser.save(err => {
      if (err){
        console.log(err);
      }else{
        res.sendStatus(200);
      }
    })
  }else{
    res.sendStatus(400).json({error: "This username has been taken"});
  }

}).catch(err => {
  console.log(err);
})

})

/* returns the user's groceryList as groceryList: [a, b, c]
*/
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

/* returns the user's pantry as pantry: [a, b, c]*/
app.get("/pantry/:userid", (req,res) => {
  let userid = req.params.userid;
  User.findById(userid)
  .then(result => {
    let mappedPantry = result.pantry.map(item => {
      return {
        itemName: item.itemName,
        daysSincePurchase: item.daysSincePurchase
      };
    })
    res.json({pantry: mappedPantry})
  })
  .catch(err => {
    res.sendStatus(400).json({error: err});
  })
});


/* adds an array of items to user's grocery list */
app.post("/addToGroceryList/:userid", (req, res) => {
  let userid = req.params.userid;
  let items = req.body.items;

  User.findByIdAndUpdate(userid)
  .then(result => {

    //do not allow duplicate items in groceryList
    items.forEach((addItem, i) => {
      result.groceryList.forEach(groceryItem => {
        if (groceryItem.itemName === addItem){
          items.splice(i, 1);
        }
      })
    })

      //map the input array to the correct format for db storage
      items = items.map(eachItem => {
        return {
          itemName: eachItem
        }
      })

      result.groceryList = result.groceryList.concat(items);
      result.save()
      .then(()=> {
        res.sendStatus(200);
      })
      .catch(err => {
        res.sendStatus(400).json({error: err});
      })
  })
});

app.post("/addToPantry/:userid",(req, res)=> {
  let userid = req.params.userid;
  let items = req.body.items;

  User.findById(userid)
  .then(result=> {

    //if the pantry contains these items already, do not re-add them
    items.forEach((addItem, i) => {
      result.pantry.forEach(pantryItem => {
        if (pantryItem.itemName === addItem){
          items.splice(i, 1);
        }
      })
    })

    //map the input array to the correct format for db storage
    items = items.map(eachItem => {
      return {
        itemName: eachItem,
        daysSincePurchase: 0
      };
    })

    result.pantry = result.pantry.concat(items);
    result.save()
    .then(()=> {
      res.sendStatus(200);
    })
    .catch(err=> {
      res.sendStatus(400).json({error: err});
    })
  })
})

app.post("/removeFromPantry/:userid",(req, res)=> {
  let userid = req.params.userid;
  let items = req.body.items;
  console.log("items to delete: " + items);
  User.findById(userid)
  .then(result => {
    // let newPantry;
    result.pantry.forEach((pantryItem, i) => {
      if (items.indexOf(pantryItem.itemName) > -1){
        result.pantry.splice(i, 1);
      }
    })

    // result.pantry = newPantry;
    result.save(err=> {
      if (err){
        res.sendStatus(400);
      }else{
        res.sendStatus(200);
      }
    })
  })
})

/* from grocery list to pantry */
app.post("/moveItemsToPantry/:userid",(req, res)=> {
  let userid = req.params.userid;
  let items = req.body.items;

  User.findById(userid)
  .then(result=> {
    let pantryItems = items.map(item => {
      return {
        itemName: item,
        daysSincePurchase: 0
      }
    })
    //adds items to pantry
    result.pantry = result.pantry.concat(pantryItems);

    //removes items from groceryList
    result.groceryList.forEach((groceryItem, i) => {
      if (items.indexOf(groceryItem.itemName) > -1){
        result.groceryList.splice(i, 1);
      }
    })
    result.save()
    .then( ()=> {
      res.sendStatus(200);
    })
    .catch(err=> {
      res.sendStatus(400).json({error: err});
    })
  })
})
