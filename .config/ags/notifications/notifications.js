const notifications = await Service.import("notifications")

const NotificationIcon = ({app_icon, app_entry, image}) => {
    if (image)
        return Widget.Box({
            class_name: "notification-icon",
            vpack: "start",
            css: `background-image: url("${image}");`
                + "background-repeat: no-repeat;"
                + "background-size: contain;"
                + "background-position: center",
        })

    if (app_entry && Utils.lookUpIcon(app_entry))
        return Widget.Box({
            class_name: "notification-icon",
            vpack: "start",
            child: Widget.Icon(app_entry),
        })

    if (app_icon && Utils.lookUpIcon(app_icon))
        return Widget.Box({
            class_name: "notification-icon",
            child: Widget.Icon(app_icon),
        })
    
    return Widget.Box({
        class_name: "notification-icon",
        vpack: "start",
        child: Widget.Icon("dialog-information-symbolic"),
    })
}

const NotificationTitle = ({summary}) => Widget.Label({
    class_name: "notification-title",
    xalign: 0,
    hexpand: true,
    max_width_chars: 24,
    truncate: "end",
    justification: "left",
    use_markup: true,
    wrap: true,
    label: summary,
})

const NotificationBody = ({body}) => Widget.Label({
    class_name: "notification-body",
    xalign: 0,
    hexpand: true,
    max_width_chars: 24,
    justification: "left",
    use_markup: true,
    wrap: true,
    label: body,
})

const NotificationActions = (notify) => Widget.Box({
    class_name: "notification-actions",
    children: notify.actions.map(({id, label}) => Widget.Button({
        class_name: "notification-action-button",
        on_clicked: () => {
            notify.invoke(id)
            notify.dismiss()
        },
        child: Widget.Label(label),
    })),
})

const Notification = (notify) => Widget.EventBox({
    attribute: {id: notify.id},
    on_primary_click: () => {notify.dismiss},
    child: Widget.Box({
        class_name: `notification-${notify.urgency}`,
        vertical: true,
        children: [
            Widget.Box({
                children: [
                    NotificationIcon(notify),
                    Widget.Box({
                        vertical: true,
                        children: [
                            NotificationTitle(notify), 
                            NotificationBody(notify),
                        ],
                    }),
                ],
            }),
            NotificationActions(notify),
        ],
    }),
})

export default (monitor = 0) => Widget.Window({
    monitor,
    name: `notifications-${monitor}`,
    class_name: "notification-popups",
    anchor: ["bottom", "right"],
    layer: "top",
    margins: [10, 10, 10, 10],
    child: Widget.Box({
        class_name: "notifications",
        spacing: 10,
        vertical: true,
        css: "min-width: 2px; min-height: 2px;",
        children: [],
        setup: self => {
            notifications.popups.forEach(notify => {
                self.children = [Notification(notify), ...self.children]
            })

            const onNotified = (_, id) => {
                const notify = notifications.getNotification(id)
                if (notify)
                    self.children = [Notification(notify), ...self.children]
            }

            const onDismissed = (_, id) => {
                const notify = self.children.find(notify => (notify.attribute.id == id))
                if (notify)
                    notify.destroy()
            }

            self.hook(notifications, onNotified, "notified")
                .hook(notifications, onDismissed, "dismissed")
        }
    })
})
