import React from "react";
import PropTypes from "prop-types";

import ModalDialog from "../../Shared/components/ModalDialog";
import Form from "./Form";

function NewEventModal(props) {
  const {
    unitId,
    anchor,
    title,
    frequency,
    duration,
    color,
    ticket,
    submitUrl,
    closeCallback,
    successCallback,
  } = props;

  return (
    <ModalDialog title="New event" closeCallback={closeCallback}>
      <Form
        unitId={unitId}
        anchor={anchor}
        submitUrl={submitUrl}
        successCallback={successCallback}
        afterSubmitCallback={closeCallback}
        title={title}
        frequency={frequency}
        duration={duration}
        color={color}
        ticket={ticket}
      />
    </ModalDialog>
  );
}

NewEventModal.propTypes = {
  closeCallback: PropTypes.func,
  unitId: PropTypes.number,
  anchor: PropTypes.objectOf(Date),
  frequency: PropTypes.string,
  title: PropTypes.string,
  duration: PropTypes.number,
  submitUrl: PropTypes.string,
  successCallback: PropTypes.func,
  color: PropTypes.string,
  ticket: PropTypes.object,
};

export default NewEventModal;
