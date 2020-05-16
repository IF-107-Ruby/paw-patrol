$(document).ready(function () {
  $("body").on("click", "#add-watchers-btn", function () {
    $("#add-watchers-btn").hide();
    $("#add-watcher-form").toggle("slide");
  });
});