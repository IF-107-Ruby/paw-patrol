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
      if ($("#event_color").val()) {
        instance.setColor($("#event_color").val());
      } else {
        $("#event_color").val(instance.getColor().toHEXA().toString());
      }
    })
    .on("save", function (color, instance) {
      $("#event_color").val(color.toHEXA().toString());
      instance.hide();
    })
    .on("clear", (instance) => {
      $("#event_color").val("");
    });
}
