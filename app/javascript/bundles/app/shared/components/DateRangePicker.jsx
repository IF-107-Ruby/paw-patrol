import React, { Component } from "react";
import PropTypes from "prop-types";

import DatePicker from "react-datepicker";
import moment from "moment";
import _ from "lodash";

import "react-datepicker/dist/react-datepicker.css";

export default class DateRangePicker extends Component {
  static propTypes = {
    initialAnchor: PropTypes.objectOf(Date),
    initialDuration: PropTypes.number,
    onChange: PropTypes.func,
  };

  constructor(props) {
    super(props);

    this.state = {
      anchor: _.get(props, "initialAnchor", moment()),
      duration: _.get(props, "initialDuration", 24 * 60),
    };
  }

  onChange = () => {
    const { anchor, duration } = this.state;
    this.props.onChange({
      anchor: moment(anchor).format('"YYYY-MM-DD HH:mm"'),
      duration,
    });
  };

  handleStartDateSelect = (date) => {
    this.setState(({ anchor, duration }) => {
      let start = moment(anchor).add("minutes", duration);
      let newDuration = moment(start).diff(moment(date), "minutes");

      return {
        duration: newDuration > 0 ? newDuration : 24 * 60,
        anchor: date,
      };
    }, this.onChange);
  };

  handleEndDateSelect = (date) => {
    this.setState(
      ({ anchor }) => ({
        duration: moment(date).diff(moment(anchor), "minutes"),
      }),
      this.onChange
    );
  };

  render() {
    const { anchor, duration } = this.state;

    let startDate = moment(anchor).toDate();
    let endDate = moment(anchor).add("minutes", duration).toDate();

    return (
      <div className="d-flex justify-content-between">
        <DatePicker
          selected={startDate}
          onChange={this.handleStartDateSelect}
          startDate={startDate}
          endDate={endDate}
          maxDate={endDate}
          timeInputLabel="Time:"
          dateFormat="MM/dd/yyyy HH:mm"
          selectsStart
          showTimeInput
        />
        <DatePicker
          selected={endDate}
          onChange={this.handleEndDateSelect}
          startDate={startDate}
          endDate={endDate}
          minDate={startDate}
          timeInputLabel="Time:"
          dateFormat="MM/dd/yyyy HH:mm"
          selectsEnd
          showTimeInput
        />
      </div>
    );
  }
}
