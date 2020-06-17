import React, { Component } from "react";

import _ from "lodash";

import cable from "../../../../channels/consumer";
import ReviewSatisfaction from "./ReviewSatisfaction";
import CompanyStatistics from "./CompanyStatistics";
import TicketsTable from "./TicketsTable";

export default class CompanyOwnerDashboard extends Component {
  constructor(props) {
    super(props);

    this.dashboardCable = cable.subscriptions.create(
      {
        channel: `DashboardsChannel`,
      },
      {
        connected: () => this.dashboardCable.dashboard_stats,
        disconnected: () => {},
        received: this.onDashboardCableReceive.bind(this),

        dashboard_stats: function () {
          this.perform("dashboard_stats");
        },

        recent_tickets: function () {
          this.perform("recent_tickets");
        },

        fun_facts: function () {
          this.perform("fun_facts");
        },

        review_rates: function () {
          this.perform("review_rates");
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

  onDashboardCableReceive({ event, data }) {
    switch (event) {
      case "@dashboardStats":
        this.setState((state) => ({ ...state, ...data }));
        break;
      case "@newTicket":
        this.onNewTicket(data);
        break;
      case "@ticketResolved":
        this.onTicketResolved(data);
        break;
      case "@recent_tickets":
        this.setState({ recent_tickets: data });
        break;
      case "@review_rates":
        this.setState({ review_rates: data });
        break;
    }
  }

  onTicketResolved(ticket) {
    this.setState((state) => {
      return {
        ...state,
        fun_facts: {
          ...state.fun_facts,
          open_tickets_count: state.fun_facts.open_tickets_count - 1,
        },
        recent_tickets: _.remove(
          state.recent_tickets,
          ({ id }) => id != ticket.id
        ),
      };
    });
  }

  onNewTicket(ticket) {
    this.setState((state) => {
      let recent_tickets = _.concat(ticket, state.recent_tickets);

      return {
        ...state,
        fun_facts: {
          ...state.fun_facts,
          open_tickets_count: state.fun_facts.open_tickets_count + 1,
          last_week_tickets_count: state.fun_facts.last_week_tickets_count + 1,
        },
        recent_tickets: _.slice(recent_tickets, 0, 11),
      };
    });
  }

  render() {
    const { fun_facts, recent_tickets, review_rates } = this.state;

    return (
      <div>
        <CompanyStatistics data={fun_facts} />
        <div className="row margin-top-20">
          <TicketsTable tickets={recent_tickets} hedline="Recent tickets" />
        </div>
        <div className="row margin-top-20">
          <ReviewSatisfaction satisfactionData={review_rates} />
        </div>
      </div>
    );
  }
}
