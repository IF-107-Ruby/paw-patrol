function registerPopupTubs() {
  var $tabsNav = $(".popup-tabs-nav"),
    $tabsNavLis = $tabsNav.children("li");

  $tabsNav.each(function () {
    var $this = $(this);

    $this
      .next()
      .children(".popup-tab-content")
      .stop(true, true)
      .hide()
      .first()
      .show();
    $this.children("li").first().addClass("active").stop(true, true).show();
  });

  $tabsNavLis.on("click", function (e) {
    var $this = $(this);

    $this.siblings().removeClass("active").end().addClass("active");

    $this
      .parent()
      .next()
      .children(".popup-tab-content")
      .stop(true, true)
      .hide()
      .siblings($this.find("a").attr("href"))
      .fadeIn();

    e.preventDefault();
  });

  var hash = window.location.hash;
  var anchor = $('.tabs-nav a[href="' + hash + '"]');
  if (anchor.length === 0) {
    $(".popup-tabs-nav li:first").addClass("active").show(); //Activate first tab
    $(".popup-tab-content:first").show(); //Show first tab content
  } else {
    anchor.parent("li").click();
  }

  // Link to Register Tab
  $(".register-tab").on("click", function (event) {
    event.preventDefault();
    $(".popup-tab-content").hide();
    $("#register.popup-tab-content").show();
    $("body").find('.popup-tabs-nav a[href="#register"]').parent("li").click();
  });

  // Disable tabs if there's only one tab
  $(".popup-tabs-nav").each(function () {
    var listCount = $(this).find("li").length;
    if (listCount < 2) {
      $(this).css({
        "pointer-events": "none",
      });
    }
  });
}
