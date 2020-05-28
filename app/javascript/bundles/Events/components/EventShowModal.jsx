import React from "react";
import PropTypes from "prop-types";

import ModalDialog from "../../Shared/components/ModalDialog";

import moment from "moment";

function EventShowModal(props) {
  return (
    <ModalDialog title={"Show event"} closeCallback={props.closeCallback}>
      <div className="px-3 pb-4">
        <div className="d-flex justify-content-between container">
          <h3>{props.event.title}</h3>
          {props.editable && (
            <div>
              <a className="mr-1" href="">
                <i
                  onClick={props.onEventEdit}
                  className="icon-feather-edit"
                ></i>
              </a>
              <a href="">
                <i
                  onClick={props.onEventDelete}
                  className="icon-feather-trash-2"
                ></i>
              </a>
            </div>
          )}
        </div>

        <hr />
        <div className="margin-top-30"></div>
        <ul className="p-0">
          <li>
            <i className="icon-material-outline-location-on mr-1"></i>
            This happens at
            <a className="ml-1" href={props.event.extendedProps.unit.url}>
              {props.event.extendedProps.unit.name}
            </a>
          </li>
          {props.event.extendedProps.ticket && (
            <li>
              <i className="icon-feather-paperclip mr-1"></i>
              Attached:{" "}
              <a href={props.event.extendedProps.ticket.url}>
                {props.event.extendedProps.ticket.name}
              </a>
            </li>
          )}
          <li>
            <i className="icon-feather-clock mr-1"></i>
            From {moment(props.event.start).format("h:mm a Do MMM")} to {""}
            {moment(props.event.end).format("h:mm a Do MMM")}
          </li>
          <li>
            <i className="icon-feather-user mr-1"></i>
            Planed by{" "}
            <a href={props.event.extendedProps.user.url}>
              {props.event.extendedProps.user.first_name}
            </a>
          </li>
        </ul>
      </div>
    </ModalDialog>
  );
}

EventShowModal.propTypes = {
  closeCallback: PropTypes.func,
  onEventEdit: PropTypes.func,
  onEventDelete: PropTypes.func,
  event: PropTypes.object,
  editable: PropTypes.bool,
};

export default EventShowModal;
