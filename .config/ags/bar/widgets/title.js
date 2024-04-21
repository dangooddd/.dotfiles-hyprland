const hyprland = await Service.import("hyprland")

export default () => Widget.Label({
    class_name: "title",
    max_width_chars: 20,
    truncate: 'end',
    setup: self => self.hook(hyprland, self => {
        self.label = hyprland.active.client.title
        if (self.label.length == 0)
            self.toggleClassName("title", false)
        else 
            self.toggleClassName("title", true)
    })
})
