$(document).ready(function(){
  $("body").on('click', '#add-comment', function(){
    $('#new-comment-form').toggle("slide");
  });
  $("body").on('click', ".reply-button", function(){
    $(this).closest('li').find(".reply-comment-form").toggle("slide");
  });
});

