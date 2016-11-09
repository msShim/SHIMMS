$(function() {
  $('.score').each(function(){
    console.log($(this).text());
    switch(parseInt($(this).text())){
      case 0:
        $(this).empty();
        $(this).append('<span class="glyphicon glyphicon-star-empty"/>');
        $(this).append('<span class="glyphicon glyphicon-star-empty"/>');
        $(this).append('<span class="glyphicon glyphicon-star-empty"/>');
        $(this).append('<span class="glyphicon glyphicon-star-empty"/>');
        $(this).append('<span class="glyphicon glyphicon-star-empty"/>');
        break;
      case 1:
        $(this).empty();
        $(this).append('<span class="glyphicon glyphicon-star"/>');
        $(this).append('<span class="glyphicon glyphicon-star-empty"/>');
        $(this).append('<span class="glyphicon glyphicon-star-empty"/>');
        $(this).append('<span class="glyphicon glyphicon-star-empty"/>');
        $(this).append('<span class="glyphicon glyphicon-star-empty"/>');
        break;
      case 2:
        $(this).empty();
        $(this).append('<span class="glyphicon glyphicon-star"/>');
        $(this).append('<span class="glyphicon glyphicon-star"/>');
        $(this).append('<span class="glyphicon glyphicon-star-empty"/>');
        $(this).append('<span class="glyphicon glyphicon-star-empty"/>');
        $(this).append('<span class="glyphicon glyphicon-star-empty"/>');
        break;
      case 3:
        $(this).empty();
        $(this).append('<span class="glyphicon glyphicon-star"/>');
        $(this).append('<span class="glyphicon glyphicon-star"/>');
        $(this).append('<span class="glyphicon glyphicon-star"/>');
        $(this).append('<span class="glyphicon glyphicon-star-empty"/>');
        $(this).append('<span class="glyphicon glyphicon-star-empty"/>');
        break;
      case 4:
        $(this).empty();
        $(this).append('<span class="glyphicon glyphicon-star"/>');
        $(this).append('<span class="glyphicon glyphicon-star"/>');
        $(this).append('<span class="glyphicon glyphicon-star"/>');
        $(this).append('<span class="glyphicon glyphicon-star"/>');
        $(this).append('<span class="glyphicon glyphicon-star-empty"/>');
        break;
      case 5:
        $(this).empty();
        $(this).append('<span class="glyphicon glyphicon-star"/>');
        $(this).append('<span class="glyphicon glyphicon-star"/>');
        $(this).append('<span class="glyphicon glyphicon-star"/>');
        $(this).append('<span class="glyphicon glyphicon-star"/>');
        $(this).append('<span class="glyphicon glyphicon-star"/>');
        break;
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


});
