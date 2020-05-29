import React, { Component } from "react";
import PropTypes from "prop-types";

import moment from "moment";

import Select from "react-select";
import AsyncSelect from "react-select/async";

import _ from "lodash";

import ColorPicker from "../../shared/components/ColorPicker";
import DateRangePicker from "../../shared/components/DateRangePicker";

import axios from "../../shared/AxiosHelper";
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

    this.original = {
      id: _.get(props, "id", null),
      title: _.get(props, "title", ""),
      anchor: moment(_.get(props, "anchor", moment())).format(
        "YYYY-MM-DD HH:mm"
      ),
      duration: _.get(props, "duration", 24 * 60),
      color: _.get(props, "color", "#0000ff"),
      ticket_id: _.get(props, "ticket.id", null),
      frequency: _.get(props, "frequency", "once"),
    };

    this.state = {
      newEventValues: _.clone(this.original),
      unitId: props.unitId,
      ticket_name: _.get(props, "ticket.name", null),
    };

    this.avaibleTickets = this.avaibleTickets.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleDateRangeChange = this.handleDateRangeChange.bind(this);
    this.handleTicketChange = this.handleTicketChange.bind(this);
    this.handleTitleChange = this.handleTitleChange.bind(this);
    this.handleColorChange = this.handleColorChange.bind(this);
    this.handleFrequencyChange = this.handleFrequencyChange.bind(this);
  }

  async avaibleTickets() {
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
  }

  handleSubmit(e) {
    e.preventDefault();

    const { newEventValues } = this.state;

    this.props.submitCallback({ ...newEventValues });

    this.props.afterSubmitCallback();
  }

  handleDateRangeChange({ anchor, duration }) {
    this.setState(({ newEventValues }) => ({
      newEventValues: {
        ...newEventValues,
        anchor,
        duration,
      },
    }));
  }

  handleTicketChange(option) {
    this.setState(({ newEventValues }) => ({
      newEventValues: {
        ...newEventValues,
        ticket_id: _.get(option, "value", null),
      },
    }));
  }

  handleColorChange(color) {
    this.setState(({ newEventValues }) => ({
      newEventValues: {
        ...newEventValues,
        color,
      },
    }));
  }

  handleTitleChange(event) {
    let title = event.target.value;

    this.setState(({ newEventValues }) => ({
      newEventValues: {
        ...newEventValues,
        title,
      },
    }));
  }

  handleFrequencyChange(option) {
    this.setState(({ newEventValues }) => ({
      newEventValues: {
        ...newEventValues,
        frequency: _.get(option, "value", "once"),
      },
    }));
  }

  render() {
    const { isNewRecord } = this.props;
    const { newEventValues, ticket_name } = this.state;
    const isChanged = isNewRecord || !_.isEqual(this.original, newEventValues);

    const {
      title,
      ticket_id,
      frequency,
      color,
      anchor,
      duration,
    } = newEventValues;

    let defaultTicket = ticket_id && {
      value: ticket_id,
      label: ticket_name,
    };

    let defaultFrequency = _.find(this.frequencies, ["value", frequency]);

    let submitClass =
      "button full-width margin-top-35 button-sliding-icon" +
      (isChanged ? "" : " dark disabled");

    let submitText = isNewRecord ? "Add event" : "Update event";

    return (
      <form onSubmit={this.handleSubmit}>
        <div>
          <label>Title</label>
          <input
            required
            id="event_title"
            className="with-border"
            type="text"
            value={title}
            onChange={this.handleTitleChange}
          />
        </div>
        <div>
          <label>Timespan</label>
          <DateRangePicker
            initialAnchor={anchor}
            initialDuration={duration}
            onChange={this.handleDateRangeChange}
          />
        </div>
        <div>
          <label>Ticket</label>
          <AsyncSelect
            defaultValue={defaultTicket}
            cacheOptions
            defaultOptions
            loadOptions={this.avaibleTickets}
            className="basic-single"
            classNamePrefix="select"
            isClearable
            isSearchable
            onChange={this.handleTicketChange}
          />
        </div>
        <div>
          <label>Frequency</label>
          <Select
            className="basic-single"
            classNamePrefix="select"
            defaultValue={defaultFrequency}
            onChange={this.handleFrequencyChange}
            options={this.frequencies}
          />
        </div>
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
  anchor: PropTypes.oneOfType([PropTypes.objectOf(Date), PropTypes.string]),
  duration: PropTypes.number,
  frequency: PropTypes.string,
  color: PropTypes.string,
  ticket: PropTypes.object,
  afterSubmitCallback: PropTypes.func,
  submitCallback: PropTypes.func,
};

export default Form;
