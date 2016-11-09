var express = require('express');
var Product = require('../models/Product');
var router = express.Router();
var multer = require('multer');
var fs = require('fs');

var storage = multer.diskStorage({
        destination: function(req, file, cb) {
            cb(null, './public/images'); // Make sure this folder exists
        },
        filename: function(req, file, cb) {
            // var ext = file.originalname.split('.').pop();
            // cb(null, file.fieldname + '-' + Date.now() + '.' + ext);
            cb(null, file.originalname);
        }
    }),
    upload = multer({ storage: storage }).single('file');

var createProductID = function(req){
  var category;
  var cafeID;
  var productNum;

  switch(req.body.category) {
    case '커피':
      category = 1;
      break;
    case '에이드/차':
      category = 2;
      break;
    case '주스':
      category = 3;
      break;
    case '더보기':
      category = 4;
      break;
    default:
      console.log('category input error!');
  }

  switch(req.body.cafeID) {
    case '명지카페':
      cafeID = 1;
      break;
    case '그라지아1':
      cafeID = 2;
      break;
    case '그라지아2':
      cafeID = 3;
      break;
    default:
      console.log('cafeID input error!');
  }

  switch(req.body.productNum.length){
    case 1:
      productNum = '000' + req.body.productNum;
      break;
    case 2:
      productNum = '00' + req.body.productNum;
      break;
    case 3:
      productNum = '0' + req.body.productNum;
      break;
    case 4:
      productNum = "" +  req.body.productNum;
      break;
    default:
      return res.redirect('back');
  }
  return {
    cafeID: cafeID,
    category: category,
    productNum: productNum,
    productID: "" + cafeID + category + productNum
  };
};

/* GET home page. */
router.get('/', function(req, res, next) {
  Product.find({}, function(err, products){
    if(err) {
      return next(err);
    }
    res.render('product/list', { products: products });
  });
});



router.get('/edit', function(req, res, next) {
  res.render('product/edit', { title: 'add' });
});

router.post('/edit/:productID', upload, function(req, res, next) {
  console.log('상품 수정');
  var productValues = createProductID(req);
  Product.findOne({productID: req.params.productID}, function(err, product) {
    if(err) {
      console.log('상품 삭제 오류');
      return next(err);
    }
    product.productNum= parseInt(req.body.productNum);
    product.category= productValues.category;
    product.cafeID= productValues.cafeID;
    product.productID= productValues.productID;
    product.name= req.body.name;
    product.price= parseInt(req.body.price);
    if(req.file){
      product.img= req.file.originalname;
    }
    product.save(function(err){
      if(err) {
        return next(err);
      }
      console.log('상품 수정 성공!');
      res.redirect('/products');
    });
  });
});

router.delete('/:productID', function(req, res, next) {
  console.log('상품 삭제');
  Product.findOneAndRemove({productID: req.params.productID}, function(err, product) {
    if(err) {
      console.log('상품 삭제 오류');
      return next(err);
    }
    res.redirect('/products');
  });
});

router.get('/edit/:productID', function(req, res, next) {
  Product.findOne({productID: req.params.productID}, function(err, product) {
    if(err) {
      console.log('상품 삭제 오류');
      return next(err);
    }
    res.render('product/edit', { title: 'add', product: product });
  });
});



router.post('/edit', upload, function(req, res, next) {
  console.log('상품 추가');
  var productValues = createProductID(req);

  Product.findOne({productID: productValues.productID}, function(err, product) {
    if(err) {
      console.log('상품 검색 오류');
      return next(err);
    }
    if(product) {
      console.log('상품 존재함');
      return res.render('product/err');
    }
    console.log('상품없음, 상품 생성 시작');
    var newProduct = new Product({
      productNum: parseInt(req.body.productNum),
      category: productValues.category,
      cafeID: productValues.cafeID,
      productID: productValues.productID,
      name: req.body.name,
      price: parseInt(req.body.price)
    });
    if(req.file){
      newProduct.img= req.file.originalname;
    }
    console.log(newProduct);

    newProduct.save(function(err){
      if(err) {
        return next(err);
      }
      console.log('상품 등록 성공!');
      res.redirect('/products');
    });
  });
});



module.exports = router;
