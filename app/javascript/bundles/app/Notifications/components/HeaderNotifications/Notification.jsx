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
    _.includes(["new_comment", "comment_reply"], notification.exemplar) &&
    _.has(notification, "noticeable.commentable_id")
  ) {
    notificationUrl = `/company/tickets/${notification.noticeable.commentable_id}`;
  }

  let notificationClass = classNames("notifications__notification", {
    "notifications__notification--read": notification.read,
  });

  let getMessage = (notificationType) => {
    switch (notificationType) {
      case "new_comment":
        return "Added new comment";
      case "comment_reply":
        return "Replied to comment";
      default:
        return "Made some action";
    }
  };

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
          {getMessage(notification.exemplar)}{" "}
          <span className="color">
            {moment(notification.created_at).fromNow()}
          </span>
        </span>
      </a>
    </li>
  );
}
