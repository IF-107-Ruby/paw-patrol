import React, { Component } from "react";

import Fullcalendar from "@fullcalendar/react";
import dayGridPlugin from "@fullcalendar/daygrid";
import interactionPlugin from "@fullcalendar/interaction";

import "@fullcalendar/core/main.css";
import "@fullcalendar/daygrid/main.css";

import moment from "moment";
import axios from "../../../AxiosHelper";

import NewEventModal from "../../Events/components/NewEventModal";
import EventShowModal from "../../Events/components/EventShowModal";
import EventEditModal from "../../Events/components/EventEditModal";
import { showSnackbarError, showSnackbarSuccess } from "../../../snackbars";

export default class Calendar extends Component {
  calendarRef = React.createRef();

  constructor(props) {
    super(props);

    this.state = {
      unitId: this.props.unit_id,
      events: [],
      modal: null,
    };
  }

  fetchEvents = async (start, end) => {
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
  };

  handleDateRender = async ({ view }) => {
    let { activeStart, activeEnd } = view;
    if (
      !moment(this.state.start).isSame(moment(activeStart)) ||
      !moment(this.state.end).isSame(moment(activeEnd))
    ) {
      await this.fetchEvents(activeStart, activeEnd);
    }
  };

  handleEventDrop = async ({ event }) => {
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
    } catch (e) {
      showSnackbarError("Event was not updated");
    }
  };

  handleEventCreated = async (event) => {
    try {
      let res = await axios.post(`/company/units/${this.state.unitId}/events`, {
        event,
      });

      if (res.status == 200 || res.status == 201) {
        showSnackbarSuccess("Event added successfully");
        await this.fetchEvents(this.state.start, this.state.end);
      }
    } catch {
      showSnackbarError("Event was not added");
    }
  };

  handleEventEdited = async (event) => {
    try {
      let res = await axios.patch(
        `/company/units/${this.state.unitId}/events/${event.id}`,
        { event }
      );

      if (res.status == 200) {
        showSnackbarSuccess("Event updated successfully");
        await this.fetchEvents(this.state.start, this.state.end);
      }
    } catch {
      showSnackbarError("Event was not updated");
    }
  };

  handleEventDelete = async (event) => {
    try {
      if (!window.confirm("Are you sure?")) return;

      let res = await axios.delete(event.extendedProps.event_url);

      if (res.status == 200) {
        this.setState({
          events: this.state.events.filter(({ id }) => id != res.data.id),
        });
        showSnackbarSuccess("Event removed successfully");
        this.handleClose();
      }
    } catch {
      showSnackbarError("Event was not removed");
    }
  };

  handleSelect = ({ start, end }) => {
    this.setState({
      newEvent: { start, end },
      modal: (
        <NewEventModal
          closeCallback={this.handleClose}
          unitId={this.props.unit_id}
          anchor={start}
          submitCallback={this.handleEventCreated}
          duration={moment(end).diff(start, "minutes")}
        />
      ),
    });
  };

  handleEventClick = async ({ event }) => {
    this.setState({
      modal: (
        <EventShowModal
          closeCallback={this.handleClose}
          editable={this.props.editable}
          event={event}
          onEventEdit={this.handleEventEdit}
          onEventDelete={this.handleEventDelete}
        />
      ),
    });
  };

  handleEventEdit = (event) => {
    this.setState({
      modal: (
        <EventEditModal
          closeCallback={this.handleClose}
          unitId={this.props.unit_id}
          id={+event.id}
          anchor={event.start}
          submitCallback={this.handleEventEdited}
          title={event.title}
          frequency={event.extendedProps.frequency}
          duration={moment(event.end).diff(event.start, "minutes")}
          ticket={event.extendedProps.ticket}
          color={event.backgroundColor}
        />
      ),
    });
  };

  handleClose = () => {
    this.setState({ modal: null });
  };

  render() {
    const { editable } = this.props;
    const { events, modal } = this.state;

    return (
      <div>
        <Fullcalendar
          defaultView="dayGridMonth"
          plugins={[dayGridPlugin, interactionPlugin]}
          header={{
            left: "prev,next today",
            center: "title",
            right: "dayGridMonth,dayGridWeek,dayGridDay",
          }}
          events={events}
          firstDay={1}
          eventTextColor="#ffffff"
          selectable={editable}
          navLinks
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
