------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    mirror = "eDP-1",
    scale = 1,
})

hl.monitor({
    output = "eDP-1",
    mode = "1920x1200@165",
--    mode = "1600x1200@165",
    scale = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "ranger"
local menu        = "rofi"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function ()
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprctl setcursor WKMouse 22")
    hl.exec_cmd("kitty")
    hl.exec_cmd("kitty --class searxng -e searxng")

    hl.dispatch(hl.dsp.cursor.move({ x = 2000, y = 1200 }))
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 0,
        gaps_out = 0,

        border_size = 2,

        col = {
            active_border   = "#fd9201",
            inactive_border = "#fd9201"},

        resize_on_border = false,

        allow_tearing = false,

        layout = "master",
    },

    decoration = {
        rounding       = 0,
        rounding_power = 0,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = false,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = false,
    },
})

hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

hl.config({
    master = {
        new_status = "master",
        mfact = 0.63,
    },
})

hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 1,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        scroll_factor = 0.9,

        sensitivity = 0.5, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.25,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(terminal .. " -e ranger"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + A", hl.dsp.window.drag())
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("flameshot gui"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("mpc play"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("mpc pause"))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("mpc next"))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("mpc clear && mpc add / && mpc shuffle && mpc play"))

hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprctl setcursor Transparent_Cursor 24"))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("hyprctl setcursor WKMouse 22"))

hl.bind(mainMod .. " + SHIFT + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CONTROL + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + CONTROL + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CONTROL + up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + CONTROL + down", hl.dsp.focus({ workspace = "e-1" }))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local suppressMaximizeRule = hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})