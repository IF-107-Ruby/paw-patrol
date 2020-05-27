import React, { Component } from "react";

import axios from "axios";
import Unit from "./Unit";

import Pagination from "../../Shared/components/Pagination";

import { showSnackbarError, showSnackbarSuccess } from "../../../snackbars";

export default class Units extends Component {
  constructor(props) {
    super(props);
    this.state = {
      units: [],
      page: this.props.page,
    };
  }

  async componentDidMount() {
    let res = await axios.get(this.props.unitsPath);

    if (res.status == 200) {
      this.setState({
        units: res.data,
        pageCount: +res.headers["total-pages"],
      });
    }
  }

  handleDestroy = async (unit) => {
    if (!window.confirm("Are you sure?")) {
      return;
    }

    let res = await axios.delete(unit.url, { params: { format: "json" } });

    if (res.status == 200) {
      showSnackbarSuccess("Unit removed successfully");
      this.setState({
        units: this.state.units.filter(({ id }) => id != res.data.id),
      });
    } else {
      showSnackbarError("Unit is not removed");
    }
  };

  onPageChange = async ({ selected }) => {
    let res = await axios.get(this.props.unitsPath, {
      params: {
        page: selected + 1,
      },
    });
    if (res.status == 200) {
      this.setState({ units: res.data });
    }
  };

  render() {
    return (
      <div className="dashboard-box">
        <div className="headline">
          <div className="d-flex justify-content-between">
            <h3>
              <i className="icon-material-outline-business"></i>
              {this.props.headline}
            </h3>
            <div className="icon-links">
              <a href={this.props.newUnitPath}>
                <i className="icon-feather-plus"></i>
              </a>
            </div>
          </div>
        </div>
        {this.state.units.length > 0 && (
          <div className="content with-padding">
            <ul className="dashboard-box-list">
              {this.state.units.map((unit) => (
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
            {this.state.pageCount && (
              <Pagination
                pageCount={this.state.pageCount}
                initialPage={this.state.page}
                onPageChange={this.onPageChange}
              />
            )}
          </div>
        )}
      </div>
    );
  }
}
