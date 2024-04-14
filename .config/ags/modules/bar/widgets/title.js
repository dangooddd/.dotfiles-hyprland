const hyprland = await Service.import("hyprland")

export default () => Widget.Label({
    class_name: "title",
    label: hyprland.active.client.bind("title"),
    maxWidthChars: 20,
    truncate: 'end',
    setup: self => self.hook(hyprland, self => {
        if (self.label.length == 0) {
            self.toggleClassName("title", false)
        } else {
            self.toggleClassName("title", true)
        }
    })
})
