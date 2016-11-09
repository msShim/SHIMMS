$(function() {
  console.log("yes");
  var socket = io('http://localhost:8000');
  socket.emit('join', 'testCode');

  socket.on('join', function(data) {
    alert('새로운 공지가 등록되었습니다.');
  });


});
