$(function() {
  $(document).on("click", ".orderSoldOut" , function() {
    var thisNum = $(this).parents('.flag').find('.orderCnt').text();
    console.log(thisNum);
    var result = confirm('주문번호 : ' + thisNum + ' 가 판매가 완료되었습니까?');

    if(result) {
       //yes
        location.replace('/orders/soldOut/' + thisNum);
    }
  });

  $(document).on("click", ".orderCancel" , function() {
    var thisNum = $(this).parents('.flag').find('.orderCnt').text();
    console.log(thisNum);
    var result = confirm('주문번호 : ' + thisNum + ' 를 주문취소 하시겠습니까?');

    if(result) {
       //yes
        location.replace('/orders/cancel/' + thisNum);
    }
  });

  $(document).on("click", ".orderCall" , function() {
    var phoneNum = $(this).parents('.flag').find('.phoneNum').text();
    console.log(phoneNum);
    var result = confirm('고객 번호 : ' + phoneNum + ' 을 호출하겠습니까?');

    if(result) {
       //yes
        location.replace('/orders/call/' + phoneNum);
    }
  });


});
