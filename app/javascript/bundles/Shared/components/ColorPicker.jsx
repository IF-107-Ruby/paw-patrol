import React, { Component } from "react";
import PropTypes from "prop-types";

import { SketchPicker } from "react-color";

class ColorPicker extends Component {
  constructor(props) {
    super(props);

    this.state = {
      displayColorPicker: false,
      color: props.initialColor,
    };
  }

  handlePickerClick = () => {
    this.setState((state) => ({
      displayColorPicker: !state.displayColorPicker,
    }));
  };

  handlePickerClose = () => {
    this.setState({ displayColorPicker: false });
  };

  onChange = (color) => {
    this.setState({ color });
    this.props.onChange(color);
  };

  render() {
    const { displayColorPicker, color } = this.state;

    return (
      <div className="d-flex align-items-center">
        <div className="picker__swatch" onClick={this.handlePickerClick}>
          <div className="picker__color" style={{ background: color }} />
        </div>
        {displayColorPicker && (
          <div className="picker__popover">
            <div className="picker__cover" onClick={this.handlePickerClose} />
            <SketchPicker color={color} onChange={this.onChange} />
          </div>
        )}
      </div>
    );
  }
}

ColorPicker.propTypes = {
  initialColor: PropTypes.string,
  onChange: PropTypes.func,
};

export default ColorPicker;
