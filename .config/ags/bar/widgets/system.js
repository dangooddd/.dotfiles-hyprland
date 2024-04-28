import options from "../../user_options.js"
const audio = await Service.import("audio")
const hyprland = await Service.import("hyprland")

const scriptsPath = "$HOME/.scripts"
const time = Variable("00:00", {
    poll: [5000, "date +%H:%M"]
})

const Clock = () => Widget.Label({
    class_name: "clock",
    label: time.bind(),
})

const SpeakerButton = () => Widget.Button({
    on_clicked: () => {
        Utils.execAsync(["bash", "-c", `${scriptsPath}/volume.sh volume_toggle`])
    },
    on_scroll_up: () => {
        Utils.execAsync(["bash", "-c", `${scriptsPath}/volume.sh volume_up`])
    },
    on_scroll_down: () => {
        Utils.execAsync(["bash", "-c", `${scriptsPath}/volume.sh volume_down`])
    },
    child: Widget.Icon().hook(audio.speaker, self => {
        const icons = {
            101: "overamplified",
            67: "high",
            34: "medium",
            1: "low",
            0: "muted",
        }
        const volume = Math.floor(audio.speaker.volume * 100 + 0.5)
        const icon = audio.speaker.stream.isMuted ? 0 : [101, 67, 34, 1, 0].find(threshold => threshold <= volume)
        self.icon = `audio-volume-${icons[icon]}-symbolic`
    }),
})

const Speaker = () => Widget.Box({
    class_name: "speaker",
    children: [
        SpeakerButton(),
        Widget.Label({
            setup: self => self.hook(audio.speaker, self => {
                self.label = `${Math.floor(audio.speaker.volume * 100 + 0.5)}`
            })
        }),
    ],
})

const MicrophoneButton = () => Widget.Button({
    on_clicked: () => {
        Utils.execAsync(["bash", "-c", `${scriptsPath}/microphone.sh sensitivity_toggle`])
    },
    on_scroll_up: () => {
        Utils.execAsync(["bash", "-c", `${scriptsPath}/microphone.sh sensitivity_up`])
    },
    on_scroll_down: () => {
        Utils.execAsync(["bash", "-c", `${scriptsPath}/microphone.sh sensitivity_down`])
    },
    child: Widget.Icon().hook(audio.microphone, self => {
        const icons = {
            1: "audio-input-microphone-symbolic",
            0: "microphone-sensitivity-muted-symbolic",
        }
        const volume = Math.floor(audio.microphone.volume * 100 + 0.5)
        const icon = audio.microphone.stream.isMuted ? 0 : volume > 0 ? 1 : 0
        self.icon = `${icons[icon]}`
    }),
})

const Microphone = () => Widget.Box({
    class_name: "microphone",
    children: [
        MicrophoneButton(),
        Widget.Label({
            setup: self => self.hook(audio.microphone, self => {
                self.label = `${Math.floor(audio.microphone.volume * 100 + 0.5)}`
            })
        }),
    ],
})

const LanguageLabel = () => Widget.Label({
    class_name: "language",
    setup: self => self.hook(hyprland, self => {
        Utils.execAsync("hyprctl -j devices")
            .then(devices => {
                const keyboard = JSON.parse(devices).keyboards.find(device => device.name == options.keyboard)
                self.label = keyboard.active_keymap.substring(0, 2).toLowerCase()
                
            })
            .catch(error => {print(error)});
    }, "keyboard-layout")
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
        }
    },
    {
        icon: "system-suspend-symbolic",
        action: () => {
            hyprland.messageAsync("dispatch exec systemctl suspend")
        }
    },
    {
        icon: "system-reboot-symbolic",
        action: () => {
            hyprland.messageAsync("dispatch exec systemctl reboot")
        }
    },
    {
        icon: "system-log-out-symbolic",
        action: () => {
            hyprland.messageAsync("dispatch exit 0")
        }
    },
]

const PowerRevealer = () => Widget.Revealer({
    reveal_child: false,
    transitionDuration: 450,
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

export default () => Widget.Box({
    class_name: "system",
    children: [
        Clock(),
        LanguageLabel(),
        Speaker(),
        Microphone(),
        PowerRevealer(),
        PowerButton("system-shutdown-symbolic", () => {
            hyprland.messageAsync("dispatch exec systemctl poweroff")    
        }),
    ],
    setup: self => {
        const i = self.children.length - 1
        self.children[i].on_secondary_click = () => {self.children[i-1].reveal_child = !self.children[i-1].reveal_child}
    }
})
