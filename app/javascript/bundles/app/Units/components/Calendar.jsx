import React, { Component } from "react";

import Fullcalendar from "@fullcalendar/react";
import dayGridPlugin from "@fullcalendar/daygrid";
import interactionPlugin from "@fullcalendar/interaction";
import listPlugin from "@fullcalendar/list";
import timeGridPlugin from "@fullcalendar/timegrid";

import moment from "moment";

import axios from "../../shared/AxiosHelper";

import NewEventModal from "../../Events/components/NewEventModal";
import EventShowModal from "../../Events/components/EventShowModal";
import EventEditModal from "../../Events/components/EventEditModal";

import { showSnackbarError, showSnackbarSuccess } from "../../../../snackbars";

import "@fullcalendar/core/main.css";
import "@fullcalendar/daygrid/main.css";
import "@fullcalendar/list/main.css";
import "@fullcalendar/timegrid/main.css";

export default class Calendar extends Component {
  calendarRef = React.createRef();

  constructor(props) {
    super(props);

    this.state = {
      unitId: this.props.unit_id,
      events: [],
      modal: null,
    };

    this.fetchEvents = this.fetchEvents.bind(this);
    this.handleDateRender = this.handleDateRender.bind(this);
    this.handleEventDrop = this.handleEventDrop.bind(this);
    this.handleEventResize = this.handleEventResize.bind(this);
    this.handleEventCreated = this.handleEventCreated.bind(this);
    this.handleEventEdited = this.handleEventEdited.bind(this);
    this.handleEventDelete = this.handleEventDelete.bind(this);
    this.handleSelect = this.handleSelect.bind(this);
    this.handleEventClick = this.handleEventClick.bind(this);
    this.handleEventEdit = this.handleEventEdit.bind(this);
    this.handleClose = this.handleClose.bind(this);
  }

  async fetchEvents(start, end) {
    try {
      const res = await axios.get(
        `/company/units/${this.state.unitId}/events`,
        {
          params: {
            start: moment(start).format("YYYY-MM-DD"),
            end: moment(end).format("YYYY-MM-DD"),
          },
        }
      );
      this.setState({ events: res.data, start, end });
    } catch {
      showSnackbarError("Can't load events");
    }
  }

  async handleDateRender({ view }) {
    let { activeStart, activeEnd } = view;
    if (
      !moment(this.state.start).isSame(moment(activeStart)) ||
      !moment(this.state.end).isSame(moment(activeEnd))
    ) {
      await this.fetchEvents(activeStart, activeEnd);
    }
  }

  async handleEventDrop({ event }) {
    try {
      let start = moment(event.start);

      let res = await axios.patch(event.extendedProps.event_url, {
        event: {
          anchor: start.format("YYYY-MM-DD HH:mm"),
        },
      });

      if (res.status == 200) {
        showSnackbarSuccess("Event moved successfully");
        await this.fetchEvents(this.state.start, this.state.end);
      }
    } catch (error) {
      if (error.response) showSnackbarError("Event was not moved");
    }
  }

  async handleEventResize({ event }) {
    try {
      let duration = moment(event.end).diff(event.start, "minutes");

      let res = await axios.patch(event.extendedProps.event_url, {
        event: { duration },
      });

      if (res.status == 200) {
        showSnackbarSuccess("Event resized successfully");
        await this.fetchEvents(this.state.start, this.state.end);
      }
    } catch (error) {
      if (error.response) showSnackbarError("Event was not resized");
    }
  }

  async handleEventCreated(event) {
    try {
      let res = await axios.post(`/company/units/${this.state.unitId}/events`, {
        event,
      });

      if (res.status == 200 || res.status == 201) {
        showSnackbarSuccess("Event added successfully");
        await this.fetchEvents(this.state.start, this.state.end);
      }
    } catch (error) {
      if (error.response) showSnackbarError("Event was not added");
    }
  }

  async handleEventEdited(event) {
    try {
      let res = await axios.patch(
        `/company/units/${this.state.unitId}/events/${event.id}`,
        { event }
      );

      if (res.status == 200) {
        showSnackbarSuccess("Event updated successfully");
        await this.fetchEvents(this.state.start, this.state.end);
      }
    } catch (error) {
      if (error.response) showSnackbarError("Event was not updated");
    }
  }

  async handleEventDelete(event) {
    try {
      if (!window.confirm("Are you sure?")) return;

      let res = await axios.delete(event.extendedProps.event_url);

      if (res.status == 200) {
        this.setState(({ events }) => ({
          events: events.filter(({ id }) => id != res.data.id),
        }));
        showSnackbarSuccess("Event removed successfully");
        this.handleClose();
      }
    } catch (error) {
      if (error.response) showSnackbarError("Event was not removed");
    }
  }

  handleSelect({ start, end }) {
    this.setState({
      modal: {
        type: "NewEventModal",
        data: {
          start,
          end,
        },
      },
    });
  }

  handleEventClick({ event }) {
    this.setState({
      modal: {
        type: "EventShowModal",
        data: event,
      },
    });
  }

  handleEventEdit(event) {
    this.setState({
      modal: {
        type: "EventEditModal",
        data: event,
      },
    });
  }

  handleClose() {
    this.setState({ modal: null });
  }

  getEewEventModal({ start, end }) {
    return (
      <NewEventModal
        closeCallback={this.handleClose}
        unitId={this.props.unit_id}
        anchor={start}
        submitCallback={this.handleEventCreated}
        duration={moment(end).diff(start, "minutes")}
      />
    );
  }

  getEventEditModal(event) {
    return (
      <EventEditModal
        closeCallback={this.handleClose}
        unitId={this.props.unit_id}
        id={_.toInteger(event.id)}
        anchor={event.start}
        submitCallback={this.handleEventEdited}
        title={event.title}
        frequency={event.extendedProps.frequency}
        duration={moment(event.end).diff(event.start, "minutes")}
        ticket={event.extendedProps.ticket}
        color={event.backgroundColor}
      />
    );
  }

  getEventShowModal(event) {
    return (
      <EventShowModal
        closeCallback={this.handleClose}
        editable={this.props.editable}
        event={event}
        onEventEdit={this.handleEventEdit}
        onEventDelete={this.handleEventDelete}
      />
    );
  }

  getModal() {
    const { modal } = this.state;
    if (_.isNil(modal)) return null;

    if (_.eq(modal.type, "NewEventModal"))
      return this.getEewEventModal(modal.data);
    if (_.eq(modal.type, "EventShowModal"))
      return this.getEventShowModal(modal.data);
    if (_.eq(modal.type, "EventEditModal"))
      return this.getEventEditModal(modal.data);
  }

  render() {
    const { editable } = this.props;
    const { events } = this.state;

    let modal = this.getModal();

    return (
      <div>
        <Fullcalendar
          defaultView="dayGridMonth"
          plugins={[
            dayGridPlugin,
            listPlugin,
            interactionPlugin,
            timeGridPlugin,
          ]}
          header={{
            left: "prev,next today",
            center: "title",
            right: "dayGridMonth,timeGridWeek,timeGridDay,listMonth",
          }}
          events={events}
          firstDay={1}
          eventTextColor="#ffffff"
          selectable={editable}
          navLinks
          nowIndicator
          eventResize={this.handleEventResize}
          editable={editable}
          eventLimit
          selectMirror
          eventDrop={this.handleEventDrop}
          datesRender={this.handleDateRender}
          select={this.handleSelect}
          eventClick={this.handleEventClick}
          ref={this.calendarRef}
        />
        {modal}
      </div>
    );
  }
}
