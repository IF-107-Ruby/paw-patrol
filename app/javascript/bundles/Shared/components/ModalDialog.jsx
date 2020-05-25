import React, { Component } from "react";

import Modal from "react-bootstrap/Modal";

export default class ModalDialog extends Component {
  constructor(props) {
    super(props);

    this.state = {
      isOpen: true,
    };
  }

  handleClose = () => {
    this.setState({ isOpen: false });
    setTimeout(this.props.closeCallback, 500);
  };

  render() {
    return (
      <Modal show={this.state.isOpen} onHide={this.handleClose} centered>
        <Modal.Header closeButton>
          <Modal.Title>{this.props.title}</Modal.Title>
        </Modal.Header>
        <Modal.Body>{this.props.children}</Modal.Body>
      </Modal>
    );
  }
}
