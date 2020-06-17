import React, { Component } from "react";

import _ from "lodash";

import cable from "../../../../channels/consumer";
import ReviewSatisfaction from "./ReviewSatisfaction";
import CompanyStatistics from "./CompanyStatistics";

class CompanyOwnerDashboard extends Component {
  constructor(props) {
    super(props);

    this.dashboardCable = cable.subscriptions.create(
      {
        channel: `DashboardsChannel`,
      },
      {
        connected: () => {
          console.log("connected!");
          this.dashboardCable.dashboard_stats();
        },
        disconnected: () => {
          console.log("disconnected!");
        },
        received: ({ event, data }) => {
          switch (event) {
            case "@dashboardStats":
              this.setState((state) => ({ ...state, ...data }));
              break;
            case "@newTicket":
              this.setState((state) => {
                let recent_tickets = _.concat(data, state.recent_tickets);

                return {
                  ...state,
                  fun_facts: {
                    ...state.fun_facts,
                    open_tickets_count: state.fun_facts.open_tickets_count + 1,
                    last_week_tickets_count:
                      state.fun_facts.last_week_tickets_count + 1,
                  },
                  recent_tickets: _.slice(recent_tickets, 0, 11),
                };
              });
              break;
            case "@ticketResolved":
              this.setState((state) => {
                return {
                  ...state,
                  fun_facts: {
                    ...state.fun_facts,
                    open_tickets_count: state.fun_facts.open_tickets_count - 1,
                  },
                  recent_tickets: _.remove(
                    state.recent_tickets,
                    ({ id }) => id != data.id
                  ),
                };
              });
              break;
            case "@recent_tickets":
              this.setState({ recent_tickets: data });
              break;
            case "@review_rates":
              this.setState({ review_rates: data });
              break;
            default:
              console.log(event, data);
              break;
          }
        },

        dashboard_stats: function () {
          this.perform("dashboard_stats");
        },

        recent_tickets: function () {
          this.perform("recent_tickets");
        },
      }
    );

    const { data } = props;

    this.state = {
      recent_tickets: _.get(data, "recent_tickets", []),
      fun_facts: _.get(data, "fun_facts", []),
      review_rates: _.get(data, "review_rates", []),
    };
  }

  render() {
    let recentTickets = this.state.recent_tickets.map(
      ({ id, name, user, responsible_user, unit }) => (
        <tr key={id}>
          <td>
            <a href={`/company/tickets/${id}`}>{name}</a>
          </td>
          <td>
            <a href={`/company/users/${user.id}`}>
              {user.first_name + " " + user.last_name}
            </a>
          </td>
          <td>
            {_.isNil(responsible_user) || (
              <a href={`/company/users/${responsible_user.id}`}>
                {_.get(responsible_user, "first_name") +
                  " " +
                  _.get(responsible_user, "last_name")}
              </a>
            )}
          </td>
          <td>
            <a href={`/company/units${unit.id}`}>{unit.name}</a>
          </td>
        </tr>
      )
    );

    return (
      <div>
        <CompanyStatistics data={this.state.fun_facts} />
        <div className="row margin-top-20">
          <div className="col-md-12">
            <div className="dashboard-box">
              <div className="headline">
                <h3>
                  <i className="icon-material-outline-library-books"></i>
                  Recent tickets
                </h3>
              </div>
              <div className="content with-padding padding-bottom-20">
                <table className="basic-table">
                  <thead>
                    <tr>
                      <th>Ticket name</th>
                      <th>Opener</th>
                      <th>Responsible user</th>
                      <th>Unit</th>
                    </tr>
                  </thead>
                  <tbody>{recentTickets}</tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
        <div className="row margin-top-20">
          <div className="col-md-6">
            <div className="dashboard-box">
              <div className="headline">
                <h3>
                  <i className="icon-feather-bar-chart-2"></i> Rewiew
                  satisfaction
                </h3>
              </div>
              <div className="content">
                <ReviewSatisfaction
                  satisfactionData={this.state.review_rates}
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default CompanyOwnerDashboard;
