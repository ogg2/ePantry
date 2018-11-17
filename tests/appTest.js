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
