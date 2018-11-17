var request = require('supertest');
var app = require('../app');

describe("app", function () {
  it("welcomes the user", function (done) {
    request(app).get('/')
    .expect(200)
    .expect(/Welcome to ePantry backend/, done())
  })
})

describe("login", function(){
  it ("error because this user does not exist", function (done) {
    request(app).post("/login")
    .send({username: "asdfghj", password: "dfgbhn"})
    .expect(400, done())
  })
})

describe("register", function(){
  it ("registers the user and returns 200", function (done) {
    request(app).post("/register")
    .send({username: "asdfghj", password: "dfgbhn"})
    .expect(200, done())
  })
})

describe("login", function(){
  it ("logs the user in after registration", function (done) {
    request(app).post("/login")
    .send({username: "asdfghj", password: "dfgbhn"})
    .expect(200, done())
  })
})

describe("register", function(){
  it ("error because this user has been registered already ", function (done) {
    request(app).post("/register")
    .send({username: "asdfghj", password: "dfgbhn"})
    .expect(400, done())
  })
})

describe("get grocery list", function(){
  it ("get grocery list of the user", function (done) {
    request(app).get("/groceryList/5bd333da62b513070fbce06b")
    .expect(200, done())
  })
})

describe("get grocery list", function(){
  it ("get grocery list of the non-existent", function (done) {
    request(app).get("/groceryList/287462389ksjfb")
    .expect(400, done())
  })
})

describe("get pantry", function(){
  it ("get pantry of the non-existent", function (done) {
    request(app).get("/groceryList/287462389ksjfb")
    .expect(400, done())
  })
})

describe("get pantry", function(){
  it ("get pantry of a user", function (done) {
    request(app).get("/groceryList/5bd333da62b513070fbce06b")
    .expect(200, done())
  })
})

describe("add to grocery list", function(){
  it ("add to user's grocery list", function (done) {
    request(app).post("/addToGroceryList/5bd333da62b513070fbce06b")
    .send({items: ["apples", "bananas"]})
    .expect(200, done())
  })
})

describe("add to grocery list", function(){
  it ("add to user's grocery list, non-existent user", function (done) {
    request(app).post("/addToGroceryList/287462389ksjfb")
    .send({items: ["apples", "bananas"]})
    .expect(400, done())
  })
})

describe("add to pantry", function(){
  it ("add to user's pantry", function (done) {
    request(app).post("/addToGroceryList/5bd333da62b513070fbce06b")
    .send({items: ["apples", "bananas"]})
    .expect(200, done())
  })
})

describe("add to pantry", function(){
  it ("add to user's pantry, non-existent user", function (done) {
    request(app).post("/addToGroceryList/287462389ksjfb")
    .send({items: ["apples", "bananas"]})
    .expect(400, done())
  })
})
