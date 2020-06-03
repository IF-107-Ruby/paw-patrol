import React from 'react';
import StatisticsItem from './StatisticsItem';

const CompanyStatistics = props => {
  const { data } = props;
    
  return (
    <section className='company-statistics'>
      <div className="fun-facts-container">
          {data.map(item => {
            return <StatisticsItem number={item.value} subtitle={item.subtitle} key={item.value} />
          })}
        </div>
    </section>
  );
}

export default CompanyStatistics;