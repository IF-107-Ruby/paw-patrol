import React from "react";

export default function TicketsTable(props) {
  const { tickets, headline } = props;

  let tableBody = tickets.map(({ id, name, user, responsible_user, unit }) => (
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
  ));

  return (
    <div className="col-md-12">
      <div className="dashboard-box">
        <div className="headline">
          <h3>
            <i className="icon-material-outline-library-books"></i>
            {headline}
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
            <tbody>{tableBody}</tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
