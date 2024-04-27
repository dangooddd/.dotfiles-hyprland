import Bar from "./bar/bar.js";
const hyprland = await Service.import("hyprland")

App.config({
    style: "./style.css",
    windows: [
        Bar(),
    ],
})

hyprland.connect("monitor-added", (_hypr, monitor) => {
    var id = -1
    for (var mt of hyprland.monitors) {
        if (mt.name == monitor)
            id = mt.id
            break;
    }
    id = id == -1 ? 0 : id
    
    var flag = true
    for (var wd of App.windows) {
        if (wd.name == `bar-${id}`)
            flag = false
            break;
    }

    if (flag)
        App.addWindow(Bar(id))
})
