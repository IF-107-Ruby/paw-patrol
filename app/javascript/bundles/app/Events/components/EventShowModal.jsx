import React from "react";

import moment from "moment";

import ModalDialog from "../../shared/components/ModalDialog";

function EventShowModal(props) {
  const { event, closeCallback, editable, onEventEdit, onEventDelete } = props;

  let onEditClick = (e) => {
    e.preventDefault();
    onEventEdit(event);
  };

  let onDeleteClick = (e) => {
    e.preventDefault();
    onEventDelete(event);
  };

  let editButtons = editable && (
    <div>
      <a className="mr-1" onClick={onEditClick}>
        <i className="icon-feather-edit"></i>
      </a>
      <a onClick={onDeleteClick}>
        <i className="icon-feather-trash-2"></i>
      </a>
    </div>
  );

  let ticketText = event.extendedProps.ticket && (
    <li>
      <i className="icon-feather-paperclip mr-1"></i>
      Attached:{" "}
      <a href={event.extendedProps.ticket.url}>
        {event.extendedProps.ticket.name}
      </a>
    </li>
  );

  return (
    <ModalDialog title="Show event" closeCallback={closeCallback}>
      <div className="px-3 pb-4">
        <div className="d-flex justify-content-between container">
          <h3>{event.title}</h3>
          {editButtons}
        </div>

        <hr />
        <div className="margin-top-30"></div>
        <ul className="p-0">
          <li>
            <i className="icon-material-outline-location-on mr-1"></i>
            This happens at
            <a className="ml-1" href={event.extendedProps.unit.url}>
              {event.extendedProps.unit.name}
            </a>
          </li>
          {ticketText}
          <li>
            <i className="icon-feather-clock mr-1"></i>
            From {moment(event.start).format("h:mm a Do MMM")} to {""}
            {moment(event.end).format("h:mm a Do MMM")}
          </li>
          <li>
            <i className="icon-feather-user mr-1"></i>
            Planed by{" "}
            <a href={event.extendedProps.user.url}>
              {event.extendedProps.user.first_name}
            </a>
          </li>
        </ul>
      </div>
    </ModalDialog>
  );
}

export default EventShowModal;
