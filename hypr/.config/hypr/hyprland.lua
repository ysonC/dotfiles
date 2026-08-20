-- Hyprland v0.56+ configuration entry point.
-- Each module is isolated so one runtime error does not prevent unrelated
-- configuration sections from loading.

require("lua/monitors")
require("lua/autostart")
require("lua/environment")
require("lua/permissions")
require("lua/appearance")
require("lua/input")
require("lua/keybinds")
require("lua/windows")
