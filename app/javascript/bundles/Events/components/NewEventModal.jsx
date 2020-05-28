import React from "react";
import PropTypes from "prop-types";

import ModalDialog from "../../Shared/components/ModalDialog";
import Form from "./Form";

function NewEventModal(props) {
  return (
    <ModalDialog title="New event" closeCallback={props.closeCallback}>
      <Form
        unitId={props.unitId}
        anchor={props.anchor}
        submitUrl={props.submitUrl}
        successCallback={props.successCallback}
        afterSubmitCallback={props.closeCallback}
        isNewRecord
        duration={props.duration}
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
