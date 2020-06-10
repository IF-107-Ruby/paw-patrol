import React, { Component } from "react";
import StatisticsItem from "./StatisticsItem";

class CompanyStatistics extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { data } = this.props;
    return (
      <section className="company-statistics">
        <div className="fun-facts-container">
          {data.map(item => {
            return <StatisticsItem number={item.value} subtitle={item.subtitle} key={item.value} />
          })}
        </div>
      </section>
    );
  }  
}

export default CompanyStatistics;