import Workspaces from "./widgets/workspaces.js"
import Title from "./widgets/title.js"
import Monitoring from "./widgets/monitoring.js"
import Tray from "./widgets/tray.js"
import System from "./widgets/system.js"

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
        Monitoring(),
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
    monitor,
    name: `bar-${monitor}`,
    class_name: "bar",
    anchor: ["top", "left", "right"],
    layer: "top",
    exclusivity: "exclusive",
    margins: [10, 10, 0, 10],
    child: Widget.CenterBox({
        css: "min-width: 2px; min-height: 2px;",
        start_widget: Left(),
        center_widget: Center(),
        end_widget: Right(),
    }),
})
