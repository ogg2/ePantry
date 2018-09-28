var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');
var mongoose = require('mongoose');

let app = express();

mongoose.connect(process.env.MONGODB_URI);
