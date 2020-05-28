import React from "react";
import PropTypes from "prop-types";

import ModalDialog from "../../shared/components/ModalDialog";
import Form from "./Form";

function NewEventModal(props) {
  const { unitId, anchor, duration, closeCallback, submitCallback } = props;

  return (
    <ModalDialog title="New event" closeCallback={closeCallback}>
      <Form
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

NewEventModal.propTypes = {
  closeCallback: PropTypes.func,
  unitId: PropTypes.number,
  anchor: PropTypes.objectOf(Date),
  duration: PropTypes.number,
  submitCallback: PropTypes.func,
};

export default NewEventModal;
