-- https://wiki.hypr.land/0.56.0/Configuring/Advanced-and-Cool/Permissions/
-- Permission changes require a full Hyprland restart.
hl.config({
    ecosystem = {
        enforce_permissions = true,
        no_update_news = true,
    },
})

hl.permission({
    binary = "/usr/(bin|local/bin)/grim",
    type = "screencopy",
    mode = "allow",
})
