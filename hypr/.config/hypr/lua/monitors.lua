-- https://wiki.hypr.land/0.56.0/Configuring/Basics/Monitors/
hl.monitor({
	output = "DP-1",
	mode = "3840x2160@240",
	position = "0x0",
	scale = 1.5,
	vrr = 1,
})

hl.config({
	-- Fix black screen flicking
	render = {
		non_shader_cm = 0,
	},
	xwayland = {
		force_zero_scaling = true,
	},
})
