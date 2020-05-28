import React, { Component } from "react";
import PropTypes from "prop-types";

import moment from "moment";
import axios from "../../../AxiosHelper";

import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

import Select from "react-select";
import AsyncSelect from "react-select/async";

import ColorPicker from "../../Shared/components/ColorPicker";

class Form extends Component {
  frequencies = [
    { value: "once", label: "Once" },
    { value: "weekly", label: "Weekly" },
    { value: "biweekly", label: "Biweekly" },
    { value: "monthly", label: "Monthly" },
    { value: "annually", label: "Annually" },
  ];

  changedButtonClass = "button full-width margin-top-35 button-sliding-icon";
  unchangedButtonClass =
    "button full-width margin-top-35 button-sliding-icon dark disabled";

  constructor(props) {
    super(props);

    let original = {
      id: props.id || null,
      title: props.title || "",
      anchor: props.anchor || moment(),
      duration: props.duration || 24 * 60,
      color: props.color || "#0000ff",
      ticket_id: (props.ticket && props.ticket.id) || null,
      frequency: props.frequency || "once",
    };

    this.state = {
      original,
      unitId: props.unitId,
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
      `/company/units/${this.state.unitId}/events/avaible_tickets`
    );

    if (res.status == 200)
      return res.data.map(({ id, name }) => {
        return { value: id, label: name };
      });
    return [];
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

    let startDate = moment(anchor);
    let endDate = moment(anchor).add("minutes", duration);

    let submitClass = isChanged
      ? this.changedButtonClass
      : this.unchangedButtonClass;

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
            selected={startDate.toDate()}
            onChange={this.handleStartDateSelect}
            startDate={startDate.toDate()}
            endDate={endDate.toDate()}
            timeInputLabel="Time:"
            dateFormat="MM/dd/yyyy hh:mm aa"
            selectsStart
            showTimeInput
          />
          <DatePicker
            selected={endDate.toDate()}
            onChange={this.handleEndDateSelect}
            startDate={startDate.toDate()}
            endDate={endDate.toDate()}
            minDate={startDate.toDate()}
            timeInputLabel="Time:"
            dateFormat="MM/dd/yyyy h:mm aa"
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
          defaultValue={
            this.frequencies.find(({ value }) => frequency == value) ||
            this.frequencies[0]
          }
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
