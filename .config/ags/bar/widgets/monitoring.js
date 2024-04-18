const scriptPath = "$HOME/.scripts/system-monitor.py"

const monitoring = [
    {
        name: "cpu",
        exec: "get_cpu_load",
        interval: 10000,
    },
    {
        name: "ram",
        exec: "get_memory_load",
        interval: 10000,
    },
    {
        name: "disk",
        exec: "get_disk_load",
        interval: 100000,
    }
]

const MonitoringProgress = (exec, interval) => Widget.Label({
    class_name: "monitoring-progress",
    label: "0.0%",
    setup: self => {
        Utils.interval(interval, () => {
            Utils.execAsync(["bash", "-c", `${scriptPath} ${exec}`])
                .then(string => {self.label = string + "%"})
                .catch(error => {print(error)});
        })
    }
})

const MonitoringBox = (name, exec, interval) => Widget.Box({
    class_name: "monitoring-box",
    children: [
        Widget.Label({
            class_name: "monitoring-label",
            label: name.toUpperCase(),
        }),
        MonitoringProgress(exec, interval),
    ]
})

export default () => Widget.Box({
    class_name: "monitoring",
    spacing: 15,
    children: monitoring.map(obj => MonitoringBox(obj.name, obj.exec, obj.interval))
})
