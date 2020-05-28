import React from "react";
import PropTypes from "prop-types";

import ModalDialog from "../../shared/components/ModalDialog";
import Form from "./Form";

function NewEventModal(props) {
  const {
    id,
    unitId,
    anchor,
    title,
    frequency,
    duration,
    color,
    ticket,
    closeCallback,
    submitCallback,
  } = props;

  return (
    <ModalDialog title="New event" closeCallback={closeCallback}>
      <Form
        id={id}
        unitId={unitId}
        anchor={anchor}
        title={title}
        frequency={frequency}
        duration={duration}
        color={color}
        ticket={ticket}
        submitCallback={submitCallback}
        afterSubmitCallback={closeCallback}
      />
    </ModalDialog>
  );
}

NewEventModal.propTypes = {
  closeCallback: PropTypes.func,
  unitId: PropTypes.number,
  id: PropTypes.number,
  anchor: PropTypes.objectOf(Date),
  frequency: PropTypes.string,
  title: PropTypes.string,
  duration: PropTypes.number,
  submitCallback: PropTypes.func,
  color: PropTypes.string,
  ticket: PropTypes.object,
};

export default NewEventModal;
