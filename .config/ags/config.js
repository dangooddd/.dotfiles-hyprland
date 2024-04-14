import Bar from "./modules/bar/bar.js";
import PowerMenu from "./modules/power_menu/power_menu.js"

App.config({
    style: "./style.css",
    windows: [
        Bar(),
        PowerMenu(),
    ],
})
