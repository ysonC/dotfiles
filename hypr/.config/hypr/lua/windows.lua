-- https://wiki.hypr.land/0.56.0/Configuring/Basics/Window-Rules/
-- Rule ordering is intentionally preserved from the previous configuration.
hl.window_rule({
	name = "windowrule-1",
	match = { title = "^(floatterm)$" },
	float = true,
	size = { 1600, 800 },
})

hl.window_rule({
	name = "windowrule-2",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "windowrule-3",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "windowrule-4",
	match = { fullscreen = true },
	border_color = "rgb(FFA500)",
})

hl.window_rule({
	name = "windowrule-5",
	match = { class = "spotify" },
	workspace = "11 silent",
})

hl.window_rule({
	name = "windowrule-6",
	match = { class = "ticktick" },
	workspace = "12 silent",
})
