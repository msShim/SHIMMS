var express = require('express');
var Product = require('../models/Product');
var Score = require('../models/Score');
var clientsManager = require('../socket/clientsManager');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  Score.find({}, function(err, scores){
    if(err) {
      return next(err);
    }
    return res.render('score/list', { scores: scores });
  });
});

// router.get('/test', function(req, res, next) {
//   console.log('test 덧글 진입');
//   var newScore = new Score({
//     phoneNum: '010-2070-3396',
//     text: 'test 덧글 입니다!',
//     score: 3
//   });
//   newScore.save(function(err){
//     if(err) {
//       return next(err);
//     }
//     console.log('덧글 등록 성공!');
//     return res.redirect('/scores');
//   });
// });

module.exports = router;
