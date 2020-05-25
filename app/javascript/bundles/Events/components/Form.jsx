import React, { Component } from "react";

import moment from "moment";
import axios from "axios";
import AxiosHelper from "../../../AxiosHelper";

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

    this.state = {
      title: props.title,
      unitId: props.unitId,
      displayColorPicker: false,
      anchor: props.anchor,
      duration: props.duration,
      color: props.color || "#0000ff",
      submitUrl: props.submitUrl,
      ticket_id: props.ticket && props.ticket.id,
      ticket_name: props.ticket && props.ticket.name,
      isChanged: props.isNewRecord,
      frequency: props.frequency,
    };
  }

  avaibleTickets = async () => {
    let res = await axios.get(
      `/company/units/${this.state.unitId}/events/avaible_tickets.json`
    );

    return res.data.map(({ id, name }) => {
      return { value: id, label: name };
    });
  };

  handleSubmit = async (e) => {
    e.preventDefault();
    AxiosHelper();

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
    this.setState({
      isChanged: true,
      duration: newDuration > 0 ? newDuration : 24 * 60,
      anchor: moment(date).format("YYYY-MM-DD HH:mm"),
    });
  };

  handleEndDateSelect = (date) => {
    let start = moment(this.state.anchor);
    this.setState({
      isChanged: true,
      duration: moment(date).diff(start, "minutes"),
    });
  };

  handleTicketChange = (option) => {
    this.setState({
      isChanged: (option && option.value) != this.props.ticket.id,
      ticket_id: option && option.value,
    });
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
    this.setState({
      isChanged: this.props.color != color.hex,
      color: color.hex,
    });
  };

  handleTitleChange = (event) => {
    this.setState({
      isChanged: event.target.value != this.props.title,
      title: event.target.value,
    });
  };

  onFrequencyChange = ({ value }) => {
    this.setState({
      isChanged: this.props.frequency != value,
      frequency: value,
    });
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
            dateFormat="MM/dd/yyyy HH:mm"
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
            dateFormat="MM/dd/yyyy HH:mm"
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

export default Form;
