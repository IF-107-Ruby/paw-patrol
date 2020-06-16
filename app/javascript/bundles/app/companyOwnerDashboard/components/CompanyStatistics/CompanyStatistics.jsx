import React from "react";

import _ from "lodash";

import StatisticsItem from "./StatisticsItem";

function CompanyStatistics(props) {
  const { data } = props;

  return (
    <div className="fun-facts-container">
      <StatisticsItem
        number={_.get(data, "employees_count", 0)}
        subtitle={"Workers"}
        color={"#36bd78"}
        iconClass={"icon-material-outline-group"}
      />
      <StatisticsItem
        number={_.get(data, "responsible_users_count", 0)}
        subtitle={"Responsible users"}
        color={"#efa80f"}
        iconClass={"icon-material-outline-supervisor-account"}
      />
      <StatisticsItem
        number={_.get(data, "open_tickets_count", 0)}
        subtitle={"Awaiting tickets"}
        color={"#b81b7f"}
        iconClass={"icon-feather-alert-circle"}
      />

      <StatisticsItem
        number={_.get(data, "last_week_tickets_count", 0)}
        subtitle={"Last week tickets"}
        color={"#2a41e6"}
        iconClass={"icon-feather-activity"}
      />
    </div>
  );
}

export default CompanyStatistics;
