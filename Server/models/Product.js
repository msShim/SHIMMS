var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var schema = new Schema({
  productNum: {type: Number, required: true},
  category: {type: Number, required: true},
  cafeID: {type: Number, required: true},
  productID: {type: String, required: true, unique: true},
  name: {type: String, required: true},
  price: {type: Number, required: true, default: 0},
  img: {type: String}
}, {
  toJSON: {virtuals: true},
  toObject: {virtuals: true}
});

var Product = mongoose.model('Product', schema);

module.exports = Product;
