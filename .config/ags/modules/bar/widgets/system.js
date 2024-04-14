const audio = await Service.import("audio")
const hyprland = await Service.import("hyprland")

const Clock = () => {
    const clock = Widget.Label({
        class_name: "clock",
    })

    Utils.interval(1000, () => {
        Utils.execAsync("date +%H:%M")
            .then(string => {clock.label = string})
            .catch(error => {clock.label = error});
    })

    return clock
}

const Speaker = () => Widget.Button({
    class_name: "speaker",
    on_clicked: () => audio.speaker.is_muted = !audio.speaker.is_muted,
    on_scroll_up: () => audio.speaker.volume += 0.05,
    on_scroll_down: () => audio.speaker.volume -= 0.05,
    child: Widget.Icon().hook(audio.speaker, self => {
        const icons = {
            101: "overamplified",
            67: "high",
            34: "medium",
            1: "low",
            0: "muted",
        }
        const volume = Math.ceil(audio.speaker.volume * 100)
        const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(threshold => threshold <= volume)
        const tooltip = volume > 0 ? `audio volume at ${volume}% now` : "audio is muted now"
        self.icon = `audio-volume-${icons[icon]}-symbolic`
        self.tooltip_text = tooltip            
    }),
})

const Microphone = () => Widget.Button({
    class_name: "microphone",
    on_clicked: () => audio.microphone.is_muted = !audio.microphone.is_muted,
    on_scroll_up: () => audio.microphone.volume += 0.05,
    on_scroll_down: () => audio.microphone.volume -= 0.05,
    child: Widget.Icon().hook(audio.microphone, self => {
        const icons = {
            1: "audio-input-microphone-symbolic",
            0: "microphone-sensitivity-muted-symbolic",
        }
        const volume = Math.ceil(audio.microphone.volume * 100)
        const icon = audio.microphone.is_muted ? 0 : volume > 0 ? 1 : 0
        const tooltip = volume > 0 ? `microphone sensitivity at ${volume}% now` : "microphone is muted now"
        self.icon = `${icons[icon]}`
        self.tooltip_text = tooltip       
    }),
})

const PowerButton = (icon, action) => Widget.Button({
    class_name: "power",
    on_primary_click: action,
    child: Widget.Icon({
        icon, 
        size: 18,
    })
})

const PowerRevealerItems = [
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
]

const PowerRevealer = () => Widget.Revealer({
    reveal_child: false,
    transitionDuration: 600,
    transition: 'slide_left',
    child: Widget.Box({
        children: PowerRevealerItems.map(item => PowerButton(item.icon, item.action)),
    }),
    setup: self => {
        self.child.children.forEach(btn => {
            btn.on_secondary_click = () => {self.reveal_child = !self.reveal_child}
        })
    }
})

const Power = PowerButton("system-shutdown-symbolic", () => {
    hyprland.messageAsync("dispatch exec systemctl poweroff")    
})

export default () => Widget.Box({
    class_name: "system",
    children: [
        Speaker(),
        Microphone(),
        Clock(),
        PowerRevealer(),
        PowerButton("system-shutdown-symbolic", () => {
            hyprland.messageAsync("dispatch exec systemctl poweroff")    
        }),
    ],
    setup: self => {
        self.children[4].on_secondary_click = () => {self.children[3].reveal_child = !self.children[3].reveal_child}
    }
})
