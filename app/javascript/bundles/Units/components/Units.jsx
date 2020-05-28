import React, { Component } from "react";
import PropTypes from "prop-types";

import axios from "../../../AxiosHelper";

import Unit from "./Unit";

import Pagination from "../../Shared/components/Pagination";

import { showSnackbarError, showSnackbarSuccess } from "../../../snackbars";

class Units extends Component {
  constructor(props) {
    super(props);

    this.state = {
      units: [],
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
    if (!window.confirm("Are you sure?")) return;

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
    const { headline, newUnitPath, editable } = this.props;
    const { units, pageCount, page } = this.state;

    let pagination = pageCount && (
      <Pagination
        pageCount={pageCount}
        initialPage={page}
        onPageChange={this.onPageChange}
      />
    );

    let content = units.length > 0 && (
      <div className="content with-padding">
        <ul className="dashboard-box-list">
          {units.map((unit) => (
            <li key={unit.id}>
              <Unit
                editable={editable}
                parentRef={this}
                unit={unit}
                handleDestroy={this.handleDestroy}
              />
            </li>
          ))}
        </ul>
        {pagination}
      </div>
    );

    return (
      <div className="dashboard-box">
        <div className="headline">
          <div className="d-flex justify-content-between">
            <h3>
              <i className="icon-material-outline-business"></i>
              {headline}
            </h3>
            <div className="icon-links">
              <a href={newUnitPath}>
                <i className="icon-feather-plus"></i>
              </a>
            </div>
          </div>
        </div>
        {content}
      </div>
    );
  }
}

Units.propTypes = {
  headline: PropTypes.string,
  newUnitPath: PropTypes.string,
  unitsPath: PropTypes.string,
  editable: PropTypes.bool,
};

export default Units;
