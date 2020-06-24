import React, { Component } from "react";

import moment from "moment";
import classNames from "classnames";
import _ from "lodash";

import cable from "../../../../../channels/consumer";

import "./header-notifications.scss";

export default class HeaderNotifications extends Component {
  constructor(props) {
    super(props);

    this.notificationsCable = cable.subscriptions.create(
      {
        channel: `NotificationsChannel`,
      },
      {
        connected: () => {
          this.notificationsCable.notifications();
        },
        disconnected: () => {},
        received: this.onNotificationsChannelReceive.bind(this),
        notifications: function () {
          this.perform("notifications");
        },
        notificationsReaded: function (notifications) {
          this.perform("notifications_readed", {
            notification_ids: notifications.map(({ id }) => id),
          });
        },
      }
    );

    this.state = {
      notifications: _.get(props, "notifications", []),
      isOpen: false,
    };

    this.openNotifications = this.openNotifications.bind(this);
    this.closeNotifications = this.closeNotifications.bind(this);
    this.handleNotificationsRead = this.handleNotificationsRead.bind(this);
  }

  onNotificationsChannelReceive({ event, data }) {
    switch (event) {
      case "@notifications":
        this.setState({ notifications: data });
        break;
      case "@notificationsReaded":
        _.each(data, (notification) => {
          let notificationIndex = _.findIndex(
            this.state.notifications,
            ({ id }) => id == notification.id
          );
          this.state.notifications[notificationIndex].read = notification.read;
        });
        this.forceUpdate();
        break;
      case "@newNotification":
        this.setState((state) => {
          return {
            ...state,
            notifications: _.concat(data, state.notifications),
          };
        });
        break;
    }
  }

  openNotifications(e) {
    this.setState({ isOpen: true });
  }

  closeNotifications(e) {
    this.setState({ isOpen: false });
  }

  handleNotificationsRead(notifications) {
    this.notificationsCable.notificationsReaded(notifications);
  }

  render() {
    const { notifications, isOpen } = this.state;

    let notificationsClass = classNames("hireo-header-notifications", {
      active: isOpen,
    });

    let unreadNotifications = _.filter(notifications, ({ read }) => !read);

    let notificationsList = notifications.map((notification) => (
      <li
        key={notification.id}
        className="notifications-not-read"
        onMouseEnter={() => {
          if (!notification.read) this.handleNotificationsRead([notification]);
        }}
      >
        <a>
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
    ));

    return (
      <div className={notificationsClass}>
        <div
          className="header-notifications-trigger"
          onClick={this.openNotifications}
        >
          <a>
            <i className="icon-feather-bell"></i>
            {unreadNotifications.length > 0 && (
              <span>{unreadNotifications.length}</span>
            )}
          </a>
        </div>
        {isOpen && (
          <div
            className="notifications__wrapper"
            onClick={this.closeNotifications}
          ></div>
        )}
        <div className="header-notifications-dropdown">
          <div className="header-notifications-headline">
            <h4>Notifications</h4>
            <button
              className="mark-as-read ripple-effect-dark"
              data-tippy-placement="left"
              title="Mark all as read"
              onClick={() => {
                if (unreadNotifications.length > 0)
                  this.handleNotificationsRead(unreadNotifications);
              }}
            >
              <i className="icon-feather-check-square"></i>
            </button>
          </div>
          <div className="header-notifications-content">
            <div className="header-notifications-scroll" data-simplebar="">
              <ul>{notificationsList}</ul>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
