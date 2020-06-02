import React from "react";

import ModalDialog from "../../shared/components/ModalDialog";
import EventForm from "./EventForm";

function NewEventModal(props) {
  const { unitId, anchor, duration, closeCallback, submitCallback } = props;

  return (
    <ModalDialog title="New event" closeCallback={closeCallback}>
      <EventForm
        unitId={unitId}
        anchor={anchor}
        duration={duration}
        submitCallback={submitCallback}
        afterSubmitCallback={closeCallback}
        isNewRecord
      />
    </ModalDialog>
  );
}

export default NewEventModal;
