function addUnitEventHandlers(unit_id) {
  $(`#${unit_id}_children_link`).on("ajax:success", function () {
    $(`#${unit_id}_children_link`).attr("href", "#").removeAttr("data-remote");

    var $showArrow = $(`#${unit_id}_children_link .show-arrow`);

    $showArrow.toggleClass("show-arrow-down");
    $showArrow.on("click", function () {
      $(this)
        .closest("li")
        .find(".dashboard-box-list")
        .first()
        .toggleClass("d-none");
      $(this).toggleClass("show-arrow-down");
    });
  });
}

function registerUnits() {
  $("[data-unregistered-unit-id]").each(function (index) {
    addUnitEventHandlers($(this).attr("data-unregistered-unit-id"));
    $(this).removeAttr("data-unregistered-unit-id");
  });
}

$(document).ready(function () {
  $(this).on("ajax:success", registerUnits);
  registerUnits();
});
