var mongoose = require('mongoose');
let Schema = mongoose.Schema;
let userSchema = new Schema ({
  username: {
    type: String,
    required: true
  },
  password: {
    type: String,
    required: true
  },
  groceryList: [{
    itemName: String
  }],
  pantry: [{
    itemName: String,
    daysSincePurchase: Number
  }]
});

let User = mongoose.model('user', userSchema);

module.exports = {
  User: User
}
