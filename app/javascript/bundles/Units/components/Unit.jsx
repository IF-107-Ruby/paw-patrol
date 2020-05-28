import React, { Component } from "react";
import PropTypes from "prop-types";

import pluralize from "pluralize";

import axios from "axios";
import { showSnackbarError, showSnackbarSuccess } from "../../../snackbars";

class Unit extends Component {
  constructor(props) {
    super(props);

    this.state = {
      unit: props.unit,
      childrenOpen: false,
      childrenLoaded: false,
      children: [],
    };
  }

  handleChildrenToggle = async () => {
    let res = await axios.get(this.state.unit.url + "/children.json");
    this.setState({
      childrenOpen: !this.state.childrenOpen,
      childrenLoaded: true,
      children: res.data,
    });
  };

  handleDestroy = async (unit) => {
    if (!window.confirm("Are you sure?")) {
      return;
    }
    let res = await axios.delete(unit.url, {
      params: {
        format: "json",
      },
    });

    if (res.status == 200) {
      showSnackbarSuccess("Unit removed successfully");
      this.setState(
        {
          children: this.state.children.filter(({ id }) => id != res.data.id),
        },
        () => {
          if (this.state.children.length == 0) {
            this.state.unit.hasChildren = false;
            this.forceUpdate();
          }
        }
      );
    } else {
      showSnackbarError("Unit is not removed");
    }
  };

  render() {
    return (
      <div className="w-100">
        <div className="job-listing">
          <div className="job-listing-details">
            <div className="job-listing-description">
              <h3 className="job-listing-title">
                {this.state.unit.hasChildren && (
                  <a id={`unit_${this.props.unit.id}_children`}>
                    <i
                      onClick={this.handleChildrenToggle}
                      className={`icon-material-outline-keyboard-arrow-right show-arrow ${
                        this.state.childrenOpen ? "show-arrow-down" : ""
                      }`}
                    ></i>
                  </a>
                )}
                <a href={this.state.unit.url}>{this.state.unit.name}</a>
              </h3>
              <div className="job-listing-footer">
                <ul>
                  {this.state.unit.responsible_user ? (
                    <li>
                      <i className="icon-material-outline-supervisor-account"></i>
                      {this.state.unit.responsible_user.first_name +
                        " " +
                        this.state.unit.responsible_user.last_name +
                        "  is responsible"}
                    </li>
                  ) : null}
                  <li>
                    <i className="icon-material-outline-group"></i>
                    {pluralize(
                      "Employee",
                      this.state.unit.employees_count,
                      true
                    )}
                  </li>
                </ul>
              </div>
            </div>
          </div>
          {this.props.editable && (
            <div className="buttons-to-right">
              <a
                href={`/company/units/new?parent_id=${this.props.unit.id}`}
                className="button gray ripple-effect ico"
              >
                <i className="icon-feather-plus"></i>
              </a>
              <a
                href={this.state.unit.url + "/edit"}
                className="button dark ripple-effect ico"
              >
                <i className="icon-feather-edit"></i>
              </a>
              <a
                className="button red ripple-effect ico"
                onClick={() => this.props.handleDestroy(this.state.unit)}
              >
                <i className="icon-feather-trash-2"></i>
              </a>
            </div>
          )}
        </div>
        {this.state.unit.hasChildren && this.state.childrenLoaded && (
          <div className={this.state.childrenOpen ? "" : "d-none"}>
            <ul className="dashboard-box-list">
              {this.state.children.map((unit) => (
                <li key={unit.id}>
                  <Unit
                    editable={this.props.editable}
                    parentRef={this}
                    unit={unit}
                    handleDestroy={this.handleDestroy}
                  />
                </li>
              ))}
            </ul>
          </div>
        )}
      </div>
    );
  }
}

Unit.propTypes = {
  unit: PropTypes.object,
  editable: PropTypes.bool,
  handleDestroy: PropTypes.func,
};

export default Unit;
