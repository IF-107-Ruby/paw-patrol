$(document).ready(function(){
  $("body").on('click', '#add-comment', function(){
    $('#new-comment-form').toggle("slide");
  });
  $("body").on('click', ".reply-button", function(){
    $(this).closest('li').find(".reply-comment-form").toggle("slide");
  });
  $("body").on('submit', '.js-reply-comment-form', function(e) {
    if ($(e.target).find('textarea').val() == '') {
      $('#comment-status').html("Coment can't be empty, please input some text").delay(1000).fadeIn('slow').delay(2000).fadeOut('slow');
      return false;
    }
  });
});

