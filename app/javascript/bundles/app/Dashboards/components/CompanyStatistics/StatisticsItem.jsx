import React from "react";

import { Spring } from "react-spring/renderprops";
import "./company-statistics.scss";

export default function StatisticsItem(props) {
  const { number, subtitle, iconClass, color } = props;

  return (
    <div className="fun-fact" data-fun-fact-color={color}>
      <div className="fun-fact-text">
        <span>{subtitle}</span>
        <Spring
          config={{ duration: 2000 }}
          from={{ number: 0 }}
          to={{ number: number }}
        >
          {(props) => (
            <h4>{Number(props.number.toFixed(0)).toLocaleString()}</h4>
          )}
        </Spring>
      </div>
      <div className="fun-fact-icon">
        <i className={iconClass}></i>
      </div>
    </div>
  );
}
