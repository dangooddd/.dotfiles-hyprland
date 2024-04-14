import Workspaces from "./widgets/workspaces.js"
import Title from "./widgets/title.js"
import Tray from "./widgets/tray.js"
import System from "./widgets/system.js"

const notifications = await Service.import("notifications")
function Notification() {
    const popups = notifications.bind("popups")
    return Widget.Box({
        class_name: "notification",
        visible: popups.as(p => p.length > 0),
        children: [
            Widget.Icon({
                icon: "preferences-system-notifications-symbolic",
            }),
            Widget.Label({
                label: popups.as(p => p[0]?.summary || ""),
            }),
        ],
    })
}

// layout of the bar

const Left = () => Widget.Box({
    class_name: "bar-left",
    spacing: 5,
    children: [
        Workspaces(),
        Title(),
    ],
})

const Center = () => Widget.Box({
    class_name: "bar-center",
    spacing: 5,
    children: [
        Notification(),
    ],
})

const Right = () => Widget.Box({
    class_name: "bar-right",
    hpack: "end",
    spacing: 5,
    children: [
        Tray(),
        System(),
    ],
})

export default (monitor = 0) => Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    class_name: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    layer: "top",
    exclusivity: "exclusive",
    margins: [10, 10, 0, 10],
    child: Widget.CenterBox({
        start_widget: Left(),
        center_widget: Center(),
        end_widget: Right(),
    }),
})
