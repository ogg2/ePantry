var mongoose = require('mongoose');
let userSchema = new Schema ({
  username: {
    type: String,
    required: true
  },
  password: {
    type: String,
    required: true
  },
  groceryList: {
    type: [{
      type: String
    }]
  },
  pantry: {
    type: []
  }
});

var User = mongoose.model('users', User);


module.exports = {
  User: User
}
