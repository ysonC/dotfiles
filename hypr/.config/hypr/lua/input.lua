-- https://wiki.hypr.land/0.56.0/Configuring/Basics/Variables/#input
hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Preserved example device rule from the previous config. Remove it if this
-- placeholder device does not exist on the machine.
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})
