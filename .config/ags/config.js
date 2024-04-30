import Bar from "./bar/bar.js";
const hyprland = await Service.import("hyprland")

App.config({
    style: "./style.css",
    windows: [
        Bar(),
    ],
})

hyprland.connect("monitor-added", (_, monitor) => {
    var id = 0
    for (var mt of hyprland.monitors) {
        if (mt.name == monitor)
            id = mt.id
            break;
    }
    
    var flag = true
    for (var wd of App.windows) {
        if (wd.name == `bar-${id}`)
            flag = false
            break;
    }

    if (flag)
        App.addWindow(Bar(id))
})
