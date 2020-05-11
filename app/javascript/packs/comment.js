$(document).ready(function () {
  $("body").on("click", "#add-comment", function () {
    $("#new-comment-form").toggle("slide");
  });
  $("body").on("click", ".reply-button", function () {
    $(this).closest("li").find(".reply-comment-form").toggle("slide");
  });
  $("body").on("submit", ".js-reply-comment-form", function (e) {
    if ($(e.target).find("textarea").val() == "") {
      $(e.target).find("#comment-status").addClass("warning");
      $(e.target)
        .find("#comment-status")
        .html("Comment failed to save, please try again")
        .delay(1000)
        .fadeIn("slow")
        .delay(2000)
        .fadeOut("slow");
      return false;
    }
  });
});
