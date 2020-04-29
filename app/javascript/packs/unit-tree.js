$(document).on('turbolinks:load', function() {
  $('.show-arrow').on('click', function() {
    $(this).closest('li').find(".nested-units").first().toggleClass("active");
    $(this).toggleClass('show-arrow-down');
  });
})