const hyprland = await Service.import("hyprland")

const MenuItems = [
    {
        icon: "system-lock-screen-symbolic",
        action: () => {
            hyprland.messageAsync("dispatch exec pidof hyprlock || hyprlock")
            App.closeWindow("power_menu")
        }
    },
    {
        icon: "system-suspend-symbolic",
        action: () => {
            hyprland.messageAsync("dispatch exec systemctl suspend")
            App.closeWindow("power_menu")
        }
    },
    {
        icon: "system-reboot-symbolic",
        action: () => {
            hyprland.messageAsync("dispatch exec systemctl reboot")
            App.closeWindow("power_menu")
        }
    },
    {
        icon: "system-log-out-symbolic",
        action: () => {
            hyprland.messageAsync("dispatch exit 0")
            App.closeWindow("power_menu")
        }
    },
    {
        icon: "system-shutdown-symbolic",
        action: () => {
            hyprland.messageAsync("dispatch exec systemctl poweroff")
            App.closeWindow("power_menu")
        }
    },
]

const PowerMenuButton = (icon, action) => Widget.Button({
    on_clicked: action,
    child: Widget.Icon({
        icon, 
        size: 40,
    })
})

const PowerMenuBox = () => Widget.Box({
    class_name: "power_menu_box",
    children: MenuItems.map(item => PowerMenuButton(item.icon, item.action)),
})

export default () => Widget.Window({
    name: "power_menu",
    class_name: "power_menu",
    anchor: ["top", "right"],
    visible: false,
    layer: "top",
    keymode: "exclusive",
    margins: [10, 10, 0, 10],
    child: PowerMenuBox(),
    setup: self => self
        .keybind("Escape", () => {
            App.closeWindow(self.name)
        }),
})
