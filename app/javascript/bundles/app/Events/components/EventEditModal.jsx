import React from "react";

import ModalDialog from "../../shared/components/ModalDialog";
import EventForm from "./EventForm";

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
      <EventForm
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

export default NewEventModal;
