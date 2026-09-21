-- https://wiki.hypr.land/0.56.0/Configuring/Basics/Autostart/
local programs = require("lua/programs")

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("swayosd-server")
	hl.exec_cmd("fcitx5")
	hl.exec_cmd("vicinae server")

	-- Scripts
	-- hl.exec_cmd("~/.config/hypr/scripts/ari-app-switcher.sh")
	-- Workspace post launch setup
	hl.exec_cmd(programs.browser, { workspace = "1 silent" })
	hl.exec_cmd("spotify", { workspace = "11 silent" })
	hl.exec_cmd("ticktick", { workspace = "12 silent" })

	-- Workspace 20 is reserved for hypridle; start the session on workspace 3.
	hl.dispatch(hl.dsp.focus({ workspace = 3 }))
end)
