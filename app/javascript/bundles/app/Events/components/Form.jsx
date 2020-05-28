import React, { Component } from "react";
import PropTypes from "prop-types";

import moment from "moment";

import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

import Select from "react-select";
import AsyncSelect from "react-select/async";

import _ from "lodash";

import ColorPicker from "../../shared/components/ColorPicker";
import axios from "../../../../AxiosHelper";
import { showSnackbarError } from "../../../../snackbars";

class Form extends Component {
  frequencies = [
    { value: "once", label: "Once" },
    { value: "weekly", label: "Weekly" },
    { value: "biweekly", label: "Biweekly" },
    { value: "monthly", label: "Monthly" },
    { value: "annually", label: "Annually" },
  ];

  constructor(props) {
    super(props);

    let original = {
      id: _.get(props, "id", null),
      title: _.get(props, "title", ""),
      anchor: _.get(props, "anchor", moment()),
      duration: _.get(props, "duration", 24 * 60),
      color: _.get(props, "color", "#0000ff"),
      ticket_id: _.get(props, "ticket.id", null),
      frequency: _.get(props, "frequency", "once"),
    };

    this.state = {
      original,
      unitId: props.unitId,
      isChanged: props.isNewRecord,
      ticket_name: _.get(props, "ticket.name", null),
      ...original,
    };
  }

  compareOldValues = () => {
    if (this.props.isNewRecord) return;

    let {
      id,
      title,
      anchor,
      duration,
      color,
      ticket_id,
      frequency,
    } = this.state;

    let newValues = {
      id,
      title,
      anchor,
      duration,
      color,
      ticket_id,
      frequency,
    };

    this.setState({
      isChanged: !_.isEqual(this.state.original, newValues),
    });
  };

  avaibleTickets = async () => {
    try {
      let res = await axios.get(
        `/company/units/${this.state.unitId}/events/avaible_tickets`
      );

      if (res.status == 200)
        return res.data.map(({ id, name }) => ({ value: id, label: name }));
      return [];
    } catch (error) {
      if (error.response) showSnackbarError("Unable to load avaible tickets");
    }
  };

  handleSubmit = (e) => {
    e.preventDefault();

    let {
      id,
      anchor,
      color,
      duration,
      frequency,
      title,
      ticket_id,
    } = this.state;

    this.props.submitCallback({
      id,
      anchor: moment(anchor).format("YYYY-MM-DD HH:mm"),
      color,
      duration,
      frequency,
      title,
      ticket_id,
    });

    this.props.afterSubmitCallback();
  };

  handleStartDateSelect = (date) => {
    let start = moment(this.state.anchor);
    let newDuration = moment(start).diff(date, "minutes");
    this.setState(
      {
        duration: newDuration > 0 ? newDuration : 24 * 60,
        anchor: moment(date).format("YYYY-MM-DD HH:mm"),
      },
      this.compareOldValues
    );
  };

  handleEndDateSelect = (date) => {
    let start = moment(this.state.anchor);
    this.setState(
      {
        duration: moment(date).diff(start, "minutes"),
      },
      this.compareOldValues
    );
  };

  handleTicketChange = (option) => {
    this.setState(
      {
        ticket_id: option && option.value,
      },
      this.compareOldValues
    );
  };

  handleColorChange = (color) => {
    this.setState(
      {
        color: color.hex,
      },
      this.compareOldValues
    );
  };

  handleTitleChange = (event) => {
    this.setState(
      {
        title: event.target.value,
      },
      this.compareOldValues
    );
  };

  onFrequencyChange = ({ value }) => {
    this.setState(
      {
        frequency: value,
      },
      this.compareOldValues
    );
  };

  render() {
    const { isNewRecord } = this.props;

    const {
      title,
      ticket_id,
      ticket_name,
      frequency,
      color,
      anchor,
      duration,
      isChanged,
    } = this.state;

    let startDate = moment(anchor).toDate();
    let endDate = moment(anchor).add("minutes", duration).toDate();

    let submitClass =
      "button full-width margin-top-35 button-sliding-icon" +
      (isChanged ? "" : " dark disabled");

    let submitText = isNewRecord ? "Add event" : "Update event";

    return (
      <form onSubmit={this.handleSubmit}>
        <label>Title</label>
        <input
          id="event_title"
          className="with-border"
          type="text"
          value={title}
          onChange={this.handleTitleChange}
        />
        <label>Timespan</label>
        <div className="d-flex justify-content-between">
          <DatePicker
            selected={startDate}
            onChange={this.handleStartDateSelect}
            startDate={startDate}
            endDate={endDate}
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
        <label>Ticket</label>
        <AsyncSelect
          defaultValue={
            ticket_id && {
              value: ticket_id,
              label: ticket_name,
            }
          }
          cacheOptions
          defaultOptions
          loadOptions={this.avaibleTickets}
          className="basic-single"
          classNamePrefix="select"
          isClearable
          isSearchable
          onChange={this.handleTicketChange}
        />
        <label>Frequency</label>
        <Select
          className="basic-single"
          classNamePrefix="select"
          defaultValue={_.find(this.frequencies, ["value", frequency])}
          onChange={this.onFrequencyChange}
          options={this.frequencies}
        />
        <div className="d-flex align-items-center">
          <label className="mr-2">Color</label>
          <ColorPicker initialColor={color} onChange={this.handleColorChange} />
        </div>
        <div className="row">
          <div className="col-xl-12">
            <button disabled={!isChanged} type="submit" className={submitClass}>
              {submitText}
              <i className="icon-feather-check"></i>
            </button>
          </div>
        </div>
      </form>
    );
  }
}

Form.propTypes = {
  isNewRecord: PropTypes.bool,
  unitId: PropTypes.number,
  id: PropTypes.number,
  title: PropTypes.string,
  anchor: PropTypes.objectOf(Date),
  duration: PropTypes.number,
  frequency: PropTypes.string,
  color: PropTypes.string,
  ticket: PropTypes.object,
  afterSubmitCallback: PropTypes.func,
  submitCallback: PropTypes.func,
};

export default Form;
