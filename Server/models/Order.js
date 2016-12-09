var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var schema = new Schema({
  orderCnt: {type: Number, unique: true},
  createAt: {type: Date, default: Date.now},
  phoneNum: {type: String, required: true},
  limitTime: {type:Date, required: true},
  contents: {type: Array, required: true},
  total: {type:Number, required: true},
  soldOut: {type:Boolean, required: true, default: false},
  isCancel: {type:Boolean, required: true, default: false},
  cafeID: {type: Number, required: true}
}, {
  toJSON: {virtuals: true},
  toObject: {virtuals: true}
});

var Order = mongoose.model('Order', schema);

module.exports = Order;
