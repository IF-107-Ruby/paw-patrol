import React, { Component } from "react";
import PropTypes from "prop-types";

import axios from "../../../../AxiosHelper";

import _ from "lodash";

import Unit from "../../Units/components/Unit";
import Pagination from "./Pagination";
import { showSnackbarError, showSnackbarSuccess } from "../../../../snackbars";

class Units extends Component {
  constructor(props) {
    super(props);

    this.state = {
      units: [],
      page: 1,
    };
  }

  async componentDidMount() {
    await this.loadUnits();
  }

  loadUnits = async () => {
    try {
      let res = await axios.get(this.props.unitsPath, {
        params: {
          page: this.state.page,
        },
      });

      if (res.status == 200)
        this.setState({
          units: res.data,
          page: _.toInteger(_.get(res.headers, "current-page", 1)),
          pageCount: _.toInteger(_.get(res.headers, "total-pages", 1)),
        });
    } catch {
      showSnackbarError("Unable to load units");
    }
  };

  handleDestroy = async (unit) => {
    if (!window.confirm("Are you sure?")) return;

    try {
      let res = await axios.delete(unit.url);

      if (res.status == 200) {
        showSnackbarSuccess("Unit removed successfully");
        await this.loadUnits();
      }
    } catch {
      showSnackbarError("Unit is not removed");
    }
  };

  onPageChange = ({ selected }) => {
    this.setState({ page: selected + 1 }, this.loadUnits);
  };

  render() {
    const { headline, newUnitPath, editable } = this.props;
    const { units, pageCount, page } = this.state;

    let pagination = pageCount && (
      <Pagination
        pageCount={pageCount}
        initialPage={page - 1}
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
