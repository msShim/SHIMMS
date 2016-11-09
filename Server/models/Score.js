var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var schema = new Schema({
  phoneNum: {type: String, required: true},
  text: {type: String, default: "" },
  score: {type: Number, required: true, default: 0},
  createAt: {type: Date, default: Date.now}
}, {
  toJSON: {virtuals: true},
  toObject: {virtuals: true}
});

var Score = mongoose.model('Score', schema);

module.exports = Score;
