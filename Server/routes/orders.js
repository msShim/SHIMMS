var express = require('express');
var Product = require('../models/Product');
var Order = require('../models/Order');
var clientsManager = require('../socket/clientsManager');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  Order.find({soldOut: false, isCancel: false}, function(err, orders){
    if(err) {
      return next(err);
    }
    res.render('order/list', { orders: orders });
  });
});

router.get('/cafe1', function(req, res, next) {
  Order.find({cafeID: 1, soldOut: false, isCancel: false}, function(err, orders){
    if(err) {
      return next(err);
    }
    res.render('order/list', { orders: orders });
  });
});

router.get('/cafe2', function(req, res, next) {
  Order.find({cafeID: 2, soldOut: false, isCancel: false}, function(err, orders){
    if(err) {
      return next(err);
    }
    res.render('order/list', { orders: orders });
  });
});

router.get('/cafe3', function(req, res, next) {
  Order.find({cafeID: 3, soldOut: false, isCancel: false}, function(err, orders){
    if(err) {
      return next(err);
    }
    res.render('order/list', { orders: orders });
  });
});

router.get('/soldOut/:orderCnt', function(req, res, next) {
  Order.findOne({orderCnt: req.params.orderCnt}, function(err, order){
    if(err) {
      return next(err);
    }
    order.soldOut = true;
    order.save(function(err){
      if(err) {
        return next(err);
      }
      if(order.cafeID === 1){
        for(var i in clientsManager.ordersCafe1){
          if(clientsManager.ordersCafe1[i].cafeID = order.cafeID){
            console.log("제거");
            clientsManager.ordersCafe1.splice(i, 1);
            break;
          }
        }
      }
      else if(order.cafeID === 2){
        for(var i in clientsManager.ordersCafe2){
          if(clientsManager.ordersCafe2[i].cafeID = order.cafeID){
            console.log("제거");
            clientsManager.ordersCafe2.splice(i, 1);
            break;
          }
        }
      }
      else {
        for(var i in clientsManager.ordersCafe3){
          if(clientsManager.ordersCafe3[i].cafeID = order.cafeID){
            console.log("제거");
            clientsManager.ordersCafe3.splice(i, 1);
            break;
          }
        }
      }
      for(var j in clientsManager.clients) {
        console.log(clientsManager.clients[j].phoneNum);
        if(clientsManager.clients[j].phoneNum.toString() == order.phoneNum){
          console.log('브래이크됨');
          clientsManager.clients[j].socket.emit('soldOut');
          break;
        }
      }
      clientsManager.io.emit('waitingStatus', clientsManager.ordersCafe1.length, clientsManager.ordersCafe2.length, clientsManager.ordersCafe3.length)
      return res.redirect('/orders');
    });
  });
});

router.get('/cancel/:orderCnt', function(req, res, next) {
  Order.findOne({orderCnt: req.params.orderCnt}, function(err, order){
    if(err) {
      return next(err);
    }
    order.isCancel = true;
    order.save(function(err){
      if(err) {
        return next(err);
      }
      return res.redirect('/orders');
    });
  });
});

router.get('/call/:phoneNum', function(req, res, next) {
  console.log(req.params);
  console.log('클라이언트 길이');
  console.log(clientsManager.clients.length);
  for(var i in clientsManager.clients) {
    console.log(clientsManager.clients[i].phoneNum);
    if(clientsManager.clients[i].phoneNum.toString() == req.params.phoneNum){
      console.log('브래이크됨');
      clientsManager.clients[i].socket.emit('successCall');
      break;
    }
  }
  return res.redirect('/orders');
});

// router.get('/test', function(req, res, next) {
//   console.log('test진입');
//   Order.find({}, function(err, orders){
//     if(err) {
//       return next(err);
//     }
//     limitTime = new Date();
//     limitTime.setHours(11);
//     limitTime.setMinutes(00);
//     var newOrder = new Order({
//       orderCnt: orders.length+1,
//       phoneNum: '010-2070-3396',
//       limitTime: limitTime,
//       contents: [{name:'초코아이스크림', cnt:1}, {name:'크라운산도', cnt:2}],
//       total: 5000
//     });
//     newOrder.save(function(err){
//       if(err) {
//         return next(err);
//       }
//       console.log('주문 등록 성공!');
//       return res.redirect('/orders');
//     });
//   });
// });

module.exports = router;
