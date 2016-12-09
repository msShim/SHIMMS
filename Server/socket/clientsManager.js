var app = require('../appBase');
var http = require('http');
var Product = require('../models/Product');
var Order = require('../models/Order');
var Score = require('../models/Score');

app.set('port', 8000);
var server = http.createServer(app);
server.listen(8000);

function Client(socket) {
  var self = this;
  var manager;
  var phoneNum;
  this.socket = socket;
  this.connectSuccess = function(){
    Product.find({}, function(err, products){
      if(err){
        console.log('db err');
        return;
      }
      self.socket.emit('connectSuccess', products);
    });
    console.log("send to connectSuccess");
  };

  this.socket.on("sendPhoneNum", function(phoneNum) {
    self.phoneNum = phoneNum;
    console.log(self.phoneNum);
  });

  this.socket.on("sendScore", function(score) {
    console.log(score);
    var newScore = new Score({
      phoneNum: score[0],
      text: score[1],
      score: parseInt(score[2])
    });
    newScore.save(function(err){
      if(err) {
        console.log('덧글 등록 에러');
        return
      }
      console.log('덧글 등록 성공!');
    });
  });

  this.socket.on("sendOrder", function(data){
    console.log(data);
    var productNames = data[2].split('|');
    var productCtns = data[3].split('|');
    var times = data[1].split(':');
    productNames.splice(0, 1);
    productCtns.splice(0, 1);
    var contents = [];
    for (i in productNames) {
      contents.push({
        name: productNames[i],
        cnt: productCtns[i]
      })
    }
    var orderCnt;
    Order.find({}, function(err, orders){
      if(err) {
        return next(err);
      }
      limitTime = new Date();
      limitTime.setHours(times[0]);
      limitTime.setMinutes(times[1]);
      var cafeID;
      if(data[5] === "명지카페"){
        cafeID = 1;
      }
      else if(data[5] === "그라지에1"){
        cafeID = 2;
      }
      else {
        cafeID = 3;
      }
      var newOrder = new Order({
        orderCnt: orders.length+1,
        phoneNum: data[0],
        limitTime: limitTime,
        contents: contents,
        total: data[4].toString(),
        cafeID: cafeID
      });
      orderCnt = newOrder.orderCnt;
      newOrder.save(function(err){
        if(err) {
          return;
        }
        self.socket.emit('orderSuccess', orderCnt);
        var order = {
          orderCnt: orderCnt
        }
        if(cafeID === 1){
          self.manager.ordersCafe1.push(order);
          console.log("Cafe1 order length : " + self.manager.ordersCafe1.length);
        }
        else if(data[5] === "그라지에1"){
          self.manager.ordersCafe2.push(order);
          console.log("Cafe2 order length : " + self.manager.ordersCafe2.length);
        }
        else {
          self.manager.ordersCafe3.push(order);
          console.log("Cafe3 order length : " + self.manager.ordersCafe3.length);
        }
        console.log('주문 등록 성공!');
        // var waitingData = {
        //   cafe1: self.manager.ordersCafe1.length,
        //   cafe2: self.manager.ordersCafe2.length,
        //   cafe3: self.manager.ordersCafe3.length
        // };
        self.manager.io.emit('waitingStatus', self.manager.ordersCafe1.length, self.manager.ordersCafe2.length, self.manager.ordersCafe3.length);
      });
    });
  });

  this.socket.on('soldOut', function(){
    console.log('soldOut');
    self.socket.emit('soldOut', "");

  });

  this.socket.on('disconnect', function(){
    console.log('disconnect');
    for(i in self.manager.clients) {
      if(self.manager.clients[i] == self){
        self.manager.clients.splice(i, 1);
      }
    }
    // console.log(self.manager);

  });
}


function ClientsManager() {
  console.log('ClientsManager create');
  this.io = require('socket.io')(server);
  this.clients = [];
  // this.cnt = 0;
  this.ordersCafe1 = [];
  this.ordersCafe2 = [];
  this.ordersCafe3 = [];
  this.addHandlers();
}

ClientsManager.prototype.addHandlers = function() {
  var manager = this;

  this.io.sockets.on("connection", function(socket) {
    var client = new Client(socket);
    manager.clients.push(client);
    client.manager = manager;
    // manager.cnt++;
    // client.socket.emit("connect", client.idx);
    console.log('connect ');
    client.connectSuccess();
  });


};

var clientsManager = new ClientsManager();

module.exports = clientsManager;
