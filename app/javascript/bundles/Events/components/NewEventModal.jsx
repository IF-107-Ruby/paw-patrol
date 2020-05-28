import React from "react";
import PropTypes from "prop-types";

import ModalDialog from "../../Shared/components/ModalDialog";
import Form from "./Form";

function NewEventModal(props) {
  const {
    unitId,
    anchor,
    duration,
    submitUrl,
    closeCallback,
    successCallback,
  } = props;

  return (
    <ModalDialog title="New event" closeCallback={closeCallback}>
      <Form
        unitId={unitId}
        anchor={anchor}
        duration={duration}
        submitUrl={submitUrl}
        successCallback={successCallback}
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
  submitUrl: PropTypes.string,
  successCallback: PropTypes.func,
};

export default NewEventModal;
