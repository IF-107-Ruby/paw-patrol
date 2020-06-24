import React from "react";

import moment from "moment";
import _ from "lodash";
import classNames from "classnames";

export default function Notification(props) {
  const { notification, onNotificationRead } = props;

  let handleMouseEnter = (e) => {
    e.preventDefault();

    onNotificationRead(notification);
  };

  let notificationUrl;

  if (
    _.isEqual(_.get(notification, "noticeable_type", false), "Comment") &&
    _.isEqual(
      _.get(notification, "noticeable.commentable_type", false),
      "Ticket"
    )
  ) {
    notificationUrl = `/company/tickets/${notification.noticeable.commentable_id}`;
  }

  let notificationClass = classNames("notifications__notification", {
    "notifications__notification--readed": notification.read,
  });

  return (
    <li className={notificationClass} onMouseEnter={handleMouseEnter}>
      <a href={notificationUrl}>
        <span className="notification-icon">
          <i className="icon-material-outline-email"></i>
        </span>
        <span className="notification-text">
          <strong>
            {notification.notified_by.first_name +
              " " +
              notification.notified_by.last_name}{" "}
          </strong>
          added new {notification.noticeable_type}{" "}
          <span className="color">
            {moment(notification.created_at).fromNow()}
          </span>
        </span>
      </a>
    </li>
  );
}
