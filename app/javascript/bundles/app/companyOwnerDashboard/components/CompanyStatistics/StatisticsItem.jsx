import React from 'react';
import { Spring } from 'react-spring/renderprops';
import './company-statistics.scss';

const StatisticsItem = props => {
  const { number, subtitle } = props;

  return (
    <div className="fun-fact col-xl-4">
      <div className="fun-fact-text">
        <span>{ subtitle }</span>
          <Spring config={{ duration: 2000 }}
            from={{ number: 0 }}
            to={{ number: number }}>
            {props => <h4>{Number(props.number.toFixed(0)).toLocaleString()}</h4> }
          </Spring> 
      </div>
      <div className="fun-fact-icon">
        <i className="icon-material-outline-group"></i>
      </div>
    </div>
    );
}

export default StatisticsItem;