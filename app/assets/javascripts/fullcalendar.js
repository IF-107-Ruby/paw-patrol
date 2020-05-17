//= require fullcalendar/core
//= require fullcalendar/daygrid
//= require fullcalendar/interaction
//= require moment
//= require daterangepicker
//= require pickr

document.addEventListener("DOMContentLoaded", function () {
  let calendarEl = document.getElementById("fullcalendar");
  let $calendar = $("#fullcalendar");
  let unitId = $calendar.attr("data-unit-id");
  let isEditable = $calendar.attr("data-editable") === "true";
  if (isEditable) {
    window.calendar = new FullCalendar.Calendar(calendarEl, {
      plugins: ["interaction", "dayGrid"],
      header: {
        left: "prev,next today",
        center: "title",
        right: "dayGridMonth,dayGridWeek,dayGridDay",
      },
      firstDay: 1,
      selectable: true,
      selectHelper: true,
      eventTextColor: "#ffffff",
      eventSources: [
        `/company/units/${unitId}/events.json`,
        `/company/units/${unitId}/recurring_events.json`,
      ],
      select: function (event) {
        let start = moment(event.start);
        let end = moment(event.end);

        $.ajax({
          url: `/company/units/${unitId}/events/new`,
          success: function () {
            $('input[data-behavior="daterangepicker"]').daterangepicker(
              {
                timePicker: true,
                startDate: start.startOf("hour"),
                endDate: end.startOf("hour"),
                opens: "left",
                locale: {
                  format: "MM/DD/YYYY HH:mm",
                },
              },
              function (start, end, label) {
                $("#event_starts_at").val(start.format("YYYY-MM-DD HH:mm"));
                $("#event_ends_at").val(end.format("YYYY-MM-DD HH:mm"));
              }
            );

            $("#daterangepicker").val(
              start.format("MM/DD/YYYY HH:mm") +
                " - " +
                end.format("MM/DD/YYYY HH:mm")
            );
            $("#event_starts_at").val(start.format("YYYY-MM-DD HH:mm"));
            $("#event_ends_at").val(end.format("YYYY-MM-DD HH:mm"));
          },
        });
      },
      eventDrop: function ({ event }) {
        let start = moment(event.start);
        let end;

        if (event.end) {
          end = moment(event.end);
        } else {
          end = start.endOf("day");
        }

        let eventData = {
          event: {
            starts_at: start.format("YYYY-MM-DD HH:mm"),
            ends_at: end.format("YYYY-MM-DD HH:mm"),
          },
          recurring_event: {
            anchor: start.format("YYYY-MM-DD HH:mm"),
          },
        };

        $.ajax({
          url: event.extendedProps.update_url,
          beforeSend: function (xhr) {
            xhr.setRequestHeader(
              "X-CSRF-Token",
              $('meta[name="csrf-token"]').attr("content")
            );
          },
          data: eventData,
          method: "PATCH",
        });
      },
      eventClick: function ({ event }) {
        $.ajax({
          url: event.extendedProps.show_url,
        });
      },
      navLinks: true,
      editable: true,
      eventLimit: true,
    });
  } else {
    var calendar = new FullCalendar.Calendar(calendarEl, {
      plugins: ["dayGrid"],
      header: {
        left: "prev,next today",
        center: "title",
        right: "dayGridMonth,dayGridWeek,dayGridDay",
      },
      eventTextColor: "#ffffff",
      firstDay: 1,
      events: `/company/units/${unitId}/events.json`,
      eventClick: function ({ event }) {
        $.ajax({
          url: event.extendedProps.show_url,
        });
      },
      navLinks: true,
      eventLimit: true,
    });
  }
  window.calendar.render();
});
