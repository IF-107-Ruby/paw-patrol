import React, { Component } from "react";

import Fullcalendar from "@fullcalendar/react";
import dayGridPlugin from "@fullcalendar/daygrid";
import interactionPlugin from "@fullcalendar/interaction";

import moment from "moment";
import axios from "axios";

import Form from "../../Events/components/Form";

import ModalDialog from "../../Shared/components/ModalDialog";
import AxiosHelper from "../../../AxiosHelper";

import { showSnackbarError, showSnackbarSuccess } from "../../../snackbars";

export default class Calendar extends Component {
  calendarRef = React.createRef();

  /**
   * @param props - Comes from your rails view.
   */
  constructor(props) {
    super(props);

    this.state = {
      unitId: this.props.unit_id,
      events: [],
      createModalIsOpen: false,
      showModalIsOpen: false,
      event: {},
    };

    this.handleClose = this.handleClose.bind(this);
  }

  handleClose() {
    this.setState({ createModalIsOpen: false });
  }

  handleSelect = ({ start, end }) => {
    this.setState({ newEvent: { start, end }, createModalIsOpen: true });
  };

  fetchEvents = async (start, end) => {
    const res = await axios.get(
      `/company/units/${this.state.unitId}/events.json`,
      {
        params: {
          start: moment(start).format("YYYY-MM-DD"),
          end: moment(end).format("YYYY-MM-DD"),
        },
      }
    );
    this.setState({ events: res.data, start, end });
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

      let eventData = {
        event: {
          anchor: start.format("YYYY-MM-DD HH:mm"),
        },
      };

      AxiosHelper();
      let res = await axios.patch(event.extendedProps.event_url, eventData);

      if (res.status == 200) {
        showSnackbarSuccess("Event moved successfully");
        await this.fetchEvents(this.state.start, this.state.end);
      }
    } catch (e) {
      showSnackbarError("Error");
    }
  };

  handleEventCreated = async (event) => {
    showSnackbarSuccess("Event added successfully");
    await this.fetchEvents(this.state.start, this.state.end);
  };

  handleEventEdited = async (event) => {
    showSnackbarSuccess("Event updated successfully");
    await this.fetchEvents(this.state.start, this.state.end);
  };

  handleEventClick = async ({ event }) => {
    this.setState({ event, showModalIsOpen: true });
  };

  handleEventDelete = async (e) => {
    e.preventDefault();
    if (!window.confirm("Are you sure?")) {
      return;
    }
    let res = await axios.delete(this.state.event.extendedProps.event_url);

    if (res.status == 200) {
      this.setState({
        events: this.state.events.filter(({ id }) => id != res.data.id),
      });
      showSnackbarSuccess("Event removed successfully");
      this.handleShowClose();
    }
  };

  handleShowClose = () => {
    this.setState({ showModalIsOpen: false });
  };

  handleEditClose = () => {
    this.setState({ editModalIsOpen: false });
  };

  handleEventEdit = (e) => {
    e.preventDefault();

    this.setState({ editModalIsOpen: true });
    this.handleShowClose();
  };

  render() {
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
          events={this.state.events}
          firstDay={1}
          eventTextColor="#ffffff"
          selectable
          navLinks
          editable
          eventLimit
          selectMirror
          eventDrop={this.handleEventDrop}
          datesRender={this.handleDateRender}
          select={this.handleSelect}
          eventClick={this.handleEventClick}
          ref={this.calendarRef}
        />
        {this.state.createModalIsOpen && (
          <ModalDialog title="New event" closeCallback={this.handleClose}>
            <Form
              unitId={this.props.unit_id}
              anchor={this.state.newEvent.start}
              submitUrl={`/company/units/${this.props.unit_id}/events.json`}
              successCallback={this.handleEventCreated}
              afterSubmitCallback={this.handleClose}
              isNewRecord
              duration={moment(this.state.newEvent.end).diff(
                this.state.newEvent.start,
                "minutes"
              )}
            />
          </ModalDialog>
        )}

        {this.state.showModalIsOpen && (
          <ModalDialog
            title={"Show event"}
            closeCallback={this.handleShowClose}
          >
            <div className="px-3 pb-4">
              <div className="d-flex justify-content-between container">
                <h3>{this.state.event.title}</h3>
                <div>
                  <a className="mr-1" href="">
                    <i
                      onClick={this.handleEventEdit}
                      className="icon-feather-edit"
                    ></i>
                  </a>
                  <a href="">
                    <i
                      onClick={this.handleEventDelete}
                      className="icon-feather-trash-2"
                    ></i>
                  </a>
                </div>
              </div>

              <hr />
              <div className="margin-top-30"></div>
              <ul className="p-0">
                <li>
                  <i className="icon-material-outline-location-on mr-1"></i>
                  This happens at
                  <a
                    className="ml-1"
                    href={this.state.event.extendedProps.unit.url}
                  >
                    {this.state.event.extendedProps.unit.name}
                  </a>
                </li>
                {this.state.event.extendedProps.ticket && (
                  <li>
                    <i className="icon-feather-paperclip mr-1"></i>
                    Attached:{" "}
                    <a href={this.state.event.extendedProps.ticket.url}>
                      {this.state.event.extendedProps.ticket.name}
                    </a>
                  </li>
                )}
                <li>
                  <i className="icon-feather-clock mr-1"></i>
                  From {moment(this.state.event.start).format(
                    "h:mm a Do MMM"
                  )}{" "}
                  to {""}
                  {moment(this.state.event.end).format("h:mm a Do MMM")}
                </li>
                <li>
                  <i className="icon-feather-user mr-1"></i>
                  Planed by{" "}
                  <a href={this.state.event.extendedProps.user.url}>
                    {this.state.event.extendedProps.user.first_name}
                  </a>
                </li>
              </ul>
            </div>
          </ModalDialog>
        )}
        {this.state.editModalIsOpen && (
          <ModalDialog
            title={"Edit event"}
            closeCallback={this.handleEditClose}
          >
            <Form
              title={this.state.event.title}
              unitId={this.props.unit_id}
              anchor={this.state.event.start}
              submitUrl={this.state.event.extendedProps.event_url}
              successCallback={this.handleEventEdited}
              frequency={this.state.event.extendedProps.frequency}
              afterSubmitCallback={this.handleEditClose}
              duration={moment(this.state.event.end).diff(
                this.state.event.start,
                "minutes"
              )}
              ticket={this.state.event.extendedProps.ticket}
              color={this.state.event.backgroundColor}
            />
          </ModalDialog>
        )}
      </div>
    );
  }
}
