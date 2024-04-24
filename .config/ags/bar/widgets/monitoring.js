const scriptPath = "$HOME/.scripts/system-monitor.py"

const monitoring = [
    {
        name: "cpu",
        value: Variable("0.0", {
            poll: [10000, `bash -c "${scriptPath} get_cpu_load"`]
        }) 
    },
    {
        name: "ram",
        value: Variable("0.0", {
            poll: [10000, `bash -c "${scriptPath} get_memory_load"`]
        })
    },
    {
        name: "disk",
        value: Variable("0.0", {
            poll: [100000, `bash -c "${scriptPath} get_disk_load"`]
        })
    }
]

const MonitoringProgress = (value) => Widget.Label({
    class_name: "monitoring-progress",
    label: value.bind().as(value => value + "%"),
})

const MonitoringBox = (name, value) => Widget.Box({
    class_name: "monitoring-box",
    children: [
        Widget.Label({
            class_name: "monitoring-label",
            label: name.toUpperCase(),
        }),
        MonitoringProgress(value),
    ]
})

export default () => Widget.Box({
    class_name: "monitoring",
    spacing: 15,
    children: monitoring.map(obj => MonitoringBox(obj.name, obj.value))
})
