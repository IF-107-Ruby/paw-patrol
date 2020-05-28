import React, { Component } from "react";
import PropTypes from "prop-types";

import moment from "moment";
import axios from "axios";

import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

import Select from "react-select";
import AsyncSelect from "react-select/async";

import { SketchPicker } from "react-color";

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
      title: props.title,
      anchor: props.anchor,
      duration: props.duration,
      color: props.color || "#0000ff",
      ticket_id: (props.ticket && props.ticket.id) || null,
      frequency: props.frequency,
    };

    this.state = {
      original,
      displayColorPicker: false,
      unitId: props.unitId,
      submitUrl: props.submitUrl,
      isChanged: props.isNewRecord,
      ticket_name: props.ticket && props.ticket.name,
      ...original,
    };
  }

  compareOldValues = () => {
    if (this.props.isNewRecord) return;
    let { title, anchor, duration, color, ticket_id, frequency } = this.state;
    let newValues = { title, anchor, duration, color, ticket_id, frequency };
    this.setState({
      isChanged:
        JSON.stringify(this.state.original) !== JSON.stringify(newValues),
    });
  };

  avaibleTickets = async () => {
    let res = await axios.get(
      `/company/units/${this.state.unitId}/events/avaible_tickets.json`
    );

    if (res.status == 200)
      return res.data.map(({ id, name }) => {
        return { value: id, label: name };
      });
    return [];
  };

  handleSubmit = async (e) => {
    e.preventDefault();

    let { anchor, color, duration, frequency, title, ticket_id } = this.state;

    let res = await (this.props.isNewRecord ? axios.post : axios.patch)(
      this.state.submitUrl,
      {
        event: {
          anchor: moment(anchor).format("YYYY-MM-DD HH:mm"),
          color,
          duration,
          frequency,
          title,
          ticket_id,
        },
      }
    );

    if (res.status == 200 || res.status == 201) {
      this.props.successCallback(res.data);
    }

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

  handlePickerClick = () => {
    this.setState({
      displayColorPicker: !this.state.displayColorPicker,
    });
  };

  handlePickerClose = () => {
    this.setState({ displayColorPicker: false });
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
    let startDate = moment(this.state.anchor);
    let endDate = moment(this.state.anchor).add("minutes", this.state.duration);

    return (
      <form onSubmit={this.handleSubmit}>
        <label>Title</label>
        <input
          id="event_title"
          className="with-border"
          type="text"
          value={this.state.title}
          onChange={this.handleTitleChange}
        />
        <label>Timespan</label>
        <div className="d-flex justify-content-between">
          <DatePicker
            selected={startDate.toDate()}
            onChange={this.handleStartDateSelect}
            selectsStart
            startDate={startDate.toDate()}
            endDate={endDate.toDate()}
            timeInputLabel="Time:"
            dateFormat="MM/dd/yyyy hh:mm aa"
            showTimeInput
          />
          <DatePicker
            selected={endDate.toDate()}
            onChange={this.handleEndDateSelect}
            selectsEnd
            startDate={startDate.toDate()}
            endDate={endDate.toDate()}
            minDate={startDate.toDate()}
            timeInputLabel="Time:"
            dateFormat="MM/dd/yyyy h:mm aa"
            showTimeInput
          />
        </div>
        <label>Ticket</label>
        <AsyncSelect
          defaultValue={
            this.props.ticket && {
              value: this.state.ticket_id,
              label: this.state.ticket_name,
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
          defaultValue={
            this.frequencies.find(
              ({ value }) => this.props.frequency == value
            ) || this.frequencies[0]
          }
          onChange={this.onFrequencyChange}
          options={this.frequencies}
        />
        <div className="d-flex align-items-center">
          <label className="mr-2">Color</label>
          <div className="picker__swatch" onClick={this.handlePickerClick}>
            <div
              className="picker__color"
              style={{ background: this.state.color }}
            />
          </div>
          {this.state.displayColorPicker ? (
            <div className="picker__popover">
              <div className="picker__cover" onClick={this.handlePickerClose} />
              <SketchPicker
                color={this.state.color}
                onChange={this.handleColorChange}
              />
            </div>
          ) : null}
        </div>
        <div className="row">
          <div className="col-xl-12">
            <button
              disabled={!this.state.isChanged}
              type="submit"
              className={`button full-width margin-top-35 button-sliding-icon ${
                !this.state.isChanged && "dark"
              }`}
            >
              {this.props.isNewRecord ? "Add event" : "Update event"}
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
  submitUrl: PropTypes.string,
  title: PropTypes.string,
  anchor: PropTypes.objectOf(Date),
  duration: PropTypes.number,
  frequency: PropTypes.string,
  color: PropTypes.string,
  ticket: PropTypes.object,
  afterSubmitCallback: PropTypes.func,
  successCallback: PropTypes.func,
};

export default Form;
