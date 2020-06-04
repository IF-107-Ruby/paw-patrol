import React, { PureComponent } from 'react';
import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend,
} from 'recharts';

import _ from "lodash";
import axios from "../../shared/AxiosHelper";

import { showSnackbarError } from "../../../../snackbars";

const CustomTooltip = ({ active, payload, label }) => {
  if (active) {
    return (
      <div className="custom-tooltip">
        <p className="label">{`Rating ${label} : ${payload[0].value}`}</p>
      </div>
    );
  }

  return null;
};

export default class RewiewSatisfaction extends PureComponent {
  static jsfiddleUrl = 'https://jsfiddle.net/alidingling/vxq4ep63/';

  constructor(props) {
    super(props);

    this.state = {
      satisfactionData: []
    }

    this.getSatisfactionData = this.getSatisfactionData.bind(this);
  }

  async componentDidMount() {
    this.getSatisfactionData();
  }

  async getSatisfactionData() {
    try {
      let res = await axios.get(
        `/company/satisfaction`
      );

      if (res.status == 200)
        this.setState({
          satisfactionData: res.data,
        });

      return [];
    } catch (error) {
      console.log(error)
      if (error.response) showSnackbarError("Unable to load satisfaction");
    }
  }

  render() {
    return (
      <BarChart
        width={500}
        height={300}
        data={this.state.satisfactionData}
        margin={{
          top: 30, right: 30, left: 20, bottom: 20,
        }}
      >
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis dataKey="name" />
        <YAxis />
        <Tooltip content={<CustomTooltip />} />
        <Legend />
        <Bar dataKey="amount" barSize={30} fill="#2a41e8" />
      </BarChart>
    );
  }
}
