import React, { Component } from "react";

import classNames from "classnames";
import _ from "lodash";

import cable from "../../../../../channels/consumer";
import Notification from "./Notification";

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
    this.handleNotificationsReaded = this.handleNotificationsReaded.bind(this);
    this.handleNotificationReaded = this.handleNotificationReaded.bind(this);
  }

  onNotificationsChannelReceive({ event, data }) {
    switch (event) {
      case "@notifications":
        this.setState({ notifications: data });
        break;
      case "@notificationsReaded":
        this.hanldeNotificationsReadedEvent(data);

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

  hanldeNotificationsReadedEvent(notifications) {
    _.each(notifications, (notification) => {
      let notificationIndex = _.findIndex(
        this.state.notifications,
        ({ id }) => id == notification.id
      );
      this.state.notifications[notificationIndex].read = notification.read;
    });
    this.forceUpdate();
  }

  openNotifications(e) {
    e.preventDefault();

    this.setState({ isOpen: true });
  }

  closeNotifications(e) {
    e.preventDefault();

    this.setState({ isOpen: false });
  }

  handleNotificationsReaded() {
    let unreadNotifications = _.filter(notifications, ({ read }) => !read);
    if (unreadNotifications.length < 1) return;

    this.notificationsCable.notificationsReaded(unreadNotifications);
  }
  handleNotificationReaded(notification) {
    if (notification.read) return;

    this.notificationsCable.notificationsReaded([notification]);
  }

  render() {
    const { notifications, isOpen } = this.state;

    let notificationsClass = classNames("hireo-header-notifications", {
      active: isOpen,
    });

    let unreadNotificationsLength = _.size(
      _.filter(notifications, ({ read }) => !read)
    );

    let notificationsList = notifications.map((notification) => (
      <Notification
        key={notification.id}
        notification={notification}
        onNotificationRead={this.handleNotificationReaded}
      />
    ));

    return (
      <div className={notificationsClass}>
        <div
          className="header-notifications-trigger"
          onClick={this.openNotifications}
        >
          <a>
            <i className="icon-feather-bell"></i>
            {unreadNotificationsLength > 0 && (
              <span>{unreadNotificationsLength}</span>
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
              onClick={this.handleNotificationsReaded}
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
