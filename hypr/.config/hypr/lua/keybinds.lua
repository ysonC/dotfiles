-- https://wiki.hypr.land/0.56.0/Configuring/Basics/Binds/
local programs = require("lua/programs")
local main_mod = "SUPER"

-- Launchers
hl.bind(main_mod .. " + B", hl.dsp.exec_cmd(programs.browser))
hl.bind(main_mod .. " + O", hl.dsp.exec_cmd("obsidian"))
hl.bind(main_mod .. " + return", hl.dsp.exec_cmd(programs.terminal))
hl.bind(main_mod .. " + E", hl.dsp.exec_cmd(programs.file_manager))
hl.bind(main_mod .. " + space", hl.dsp.exec_cmd(programs.menu))
hl.bind(main_mod .. " + A", hl.dsp.exec_cmd(programs.browser .. " --new-window \"https://chatgpt.com/\""))

-- Session controls
hl.bind(main_mod .. " + Q", hl.dsp.window.close())
hl.bind(main_mod .. " + L", hl.dsp.exit())
hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- Utility helpers
hl.bind(main_mod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(main_mod .. " + SHIFT + K", hl.dsp.exec_cmd("$HOME/.scripts/select_kill_pid.sh"))
hl.bind(main_mod .. " + SHIFT + I", hl.dsp.exec_cmd(programs.terminal .. " --title \"floatterm\" $HOME/.scripts/fzf_install_pkg.sh"))
hl.bind(main_mod .. " + SHIFT + return", hl.dsp.exec_cmd(programs.terminal .. " --title \"floatterm\""))
hl.bind(main_mod .. " + SHIFT + C", hl.dsp.exec_cmd("vicinae vicinae://launch/clipboard/history"))

-- Focus and window movement
for key, direction in pairs({ left = "l", right = "r", up = "u", down = "d" }) do
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ direction = direction }))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end
hl.bind(main_mod .. " + tab", hl.dsp.window.cycle_next())

-- Workspace switching and moving windows
for workspace = 1, 10 do
    local key = workspace % 10
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end
hl.bind(main_mod .. " + S", hl.dsp.focus({ workspace = 11 }))
hl.bind(main_mod .. " + T", hl.dsp.focus({ workspace = 12 }))

-- Special workspace
hl.bind(main_mod .. " + N", hl.dsp.workspace.toggle_special("magic"))
hl.bind(main_mod .. " + SHIFT + N", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll workspaces
hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse bindings
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Brightness and audio controls (old bindel: repeating + locked)
local repeating_locked = { repeating = true, locked = true }
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), repeating_locked)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), repeating_locked)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), repeating_locked)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), repeating_locked)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), repeating_locked)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), repeating_locked)

-- Media controls (old bindl: locked)
local locked = { locked = true }
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), locked)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), locked)
