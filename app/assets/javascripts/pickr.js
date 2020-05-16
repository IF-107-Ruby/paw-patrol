//= require pickr.min

function pickrInit() {
  window.pickr = Pickr.create({
    el: ".color-picker",
    theme: "nano",
    components: {
      preview: true,
      opacity: true,
      hue: true,

      interaction: {
        input: true,
        clear: true,
        save: true,
      },
    },
  });

  pickr
    .on("init", (instance) => {
      if ($('input[data-type="color"').val()) {
        instance.setColor($('input[data-type="color"').val());
      } else {
        $('input[data-type="color"').val(
          instance.getColor().toHEXA().toString()
        );
      }
    })
    .on("save", function (color, instance) {
      $('input[data-type="color"').val(color.toHEXA().toString());
      instance.hide();
    })
    .on("clear", (instance) => {
      $('input[data-type="color"').val("");
    });
}
