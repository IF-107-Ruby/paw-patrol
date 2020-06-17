import React from "react";
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
} from "recharts";

import _ from "lodash";

import CustomTooltip from "./CustomTooltip";

export default function RewiewSatisfaction(props) {
  const { satisfactionData } = props;

  return (
    <div className="col-md-6">
      <div className="dashboard-box">
        <div className="headline">
          <h3>
            <i className="icon-feather-bar-chart-2"></i> Rewiew satisfaction
          </h3>
        </div>
        <div className="content">
          <BarChart
            width={450}
            height={275}
            data={satisfactionData}
            margin={{
              top: 30,
              right: 30,
              left: 0,
              bottom: 20,
            }}
          >
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="name" />
            <YAxis />
            <Tooltip content={<CustomTooltip />} />
            <Legend />
            <Bar dataKey="amount" barSize={30} fill="#2a41e8" />
          </BarChart>
        </div>
      </div>
    </div>
  );
}
