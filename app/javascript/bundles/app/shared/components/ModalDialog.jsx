import React, { Component } from "react";
import PropTypes from "prop-types";

import Modal from "react-bootstrap/Modal";

class ModalDialog extends Component {
  constructor(props) {
    super(props);

    this.state = {
      isOpen: true,
    };

    this.onClose = this.onClose.bind(this);
  }

  onClose() {
    this.setState({ isOpen: false });

    setTimeout(() => this.props.closeCallback(), 500);
  }

  render() {
    const { isOpen } = this.state;
    const { title, children } = this.props;

    return (
      <Modal show={isOpen} onHide={this.onClose} centered>
        <Modal.Header closeButton>
          <Modal.Title>{title}</Modal.Title>
        </Modal.Header>
        <Modal.Body>{children}</Modal.Body>
      </Modal>
    );
  }
}

ModalDialog.propTypes = {
  title: PropTypes.string,
  closeCallback: PropTypes.func,
};

export default ModalDialog;
