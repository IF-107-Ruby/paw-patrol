import React, { Component } from "react";

import _ from "lodash";

import cable from "../../../../channels/consumer";
import ReviewSatisfaction from "../../ReviewSatisfaction/components/ReviewSatisfaction";
import CompanyStatistics from "../../companyOwnerDashboard/components/CompanyStatistics";

class CompanyDashboard extends Component {
  constructor(props) {
    super(props);
    this.cable = cable;
    this.dashboardCable = this.cable.subscriptions.create(
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
          console.log(event, data);
          switch (event) {
            case "@dashboardStats":
              this.setState((state) => ({ ...state, ...data }));
              break;
            case "@newTicket":
              this.setState((state) => {
                let tickets = _.concat(data, state.tickets);

                return {
                  ...state,
                  fun_facts: {
                    ...state.fun_facts,
                    open_tickets_count: state.fun_facts.open_tickets_count + 1,
                    last_week_tickets_count:
                      state.fun_facts.last_week_tickets_count + 1,
                  },
                  tickets: _.slice(tickets, 0, 11),
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
                  tickets: _.remove(state.tickets, ({ id }) => id != data.id),
                };
              });
              break;
            case "@tickets":
              this.setState({ tickets: data });
              break;
            default:
              break;
          }
        },

        dashboard_stats: function () {
          this.perform("dashboard_stats");
        },

        tickets: function () {
          this.perform("tickets");
        },
      }
    );

    this.state = { tickets: [], fun_facts: [] };
  }

  componentDidMount() {}

  render() {
    let recentTickets = this.state.tickets.map(
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
                <ReviewSatisfaction />
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default CompanyDashboard;
