import React, { Component } from "react";

import cable from "../../../channels/consumer";
import _ from "lodash";
import moment from "moment";

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
          this.dashboardCable.tickets();
        },
        disconnected: () => {
          console.log("disconnected!");
        },
        received: ({ event, data }) => {
          console.log(event, data);
          switch (event) {
            case "@tickets":
              this.setState({ tickets: data });
              break;
            case "@newTicket":
              this.setState((state) => {
                let tickets = _.concat(data, state.tickets);

                return {
                  ...state,
                  tickets: _.slice(tickets, 0, 11),
                };
              });
              break;
            default:
              break;
          }
        },

        tickets: function () {
          this.perform("tickets");
        },
      }
    );
    this.state = { tickets: [] };
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
    );
  }
}

export default CompanyDashboard;
