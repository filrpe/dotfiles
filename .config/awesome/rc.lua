-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
    pcall(require, "luarocks.loader")

------------------------------------------------
------------------ LIBRARIES -------------------
------------------------------------------------

-- Standard awesome library
    local gears = require("gears")
    local awful = require("awful")
    require("awful.autofocus")

-- Widget and layout library
    local watch = require("awful.widget.watch")
 --   local lain = require("lain")
    local wibox = require("wibox")

--Theme handling library
    local beautiful = require("beautiful")
    -- Themes define colours, icons, font and wallpapers.
    --beautiful.init(gears.filesystem.get_themes_dir() .. "My/theme.lua")
    beautiful.init(gears.filesystem.get_themes_dir() .. "Nord/theme.lua")

    local corner_radius = 4000

-- Adicione uma regra para aplicar cantos arredondados a todas as janelas
    awful.rules.rules = {
    -- outras regras existentes
    -- ...
    -- Regra para adicionar cantos arredondados a todas as janelas




-- Função para executar sempre que uma nova janela (cliente) for criada
    client.connect_signal("manage", function (c)
    -- Verifica se o cliente corresponde ao aplicativo que queremos em modo float
        if c.instance == "knotes" then
        -- Define o cliente como flutuante
            c.floating = true
        end
    end)


    -- Regra para o aplicativo abrir sempre em modo float

  --  {
    --    rule = {},
      --  properties = {
            -- outras propriedades existentes
            -- Defina as propriedades para cantos arredondados
        --    shape = function(cr, width, height)
          --      gears.shape.rounded_rect(cr, width, height, corner_radius)
            --end,
        --},
    --},
}








-- Notification library
    local naughty = require("naughty")
    local menubar = require("menubar")
    local hotkeys_popup = require("awful.hotkeys_popup")
    require("awful.hotkeys_popup.keys")

-- Load Debian menu entries
    local debian = require("debian.menu")
    local has_fdo, freedesktop = pcall(require, "freedesktop")

------------------------------------------------
------------------- ERRORS ---------------------
------------------------------------------------

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
    if awesome.startup_errors then
        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, there were errors during startup!",
                         text = awesome.startup_errors })
    end

-- Handle runtime errors after startup
    do
        local in_error = false
        awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
            if in_error then return end
            in_error = true

            naughty.notify({ preset = naughty.config.presets.critical,
                             title = "Oops, an error happened!",
                             text = tostring(err) })
            in_error = false
        end)
    end
-- }}}

------------------------------------------------
------------------- OPTIONS --------------------
------------------------------------------------

-- {{{ Variable definitions

-- This is used later as the default terminal and editor to run.
    terminal = "alacritty"
    editor = os.getenv("EDITOR") or "nvim"
    editor_cmd = terminal .. " -e " .. "nvim"
    browser = "firefox"
    fm = "nautilus"

-- Default modkey.
    --modkey = "Mod4" -- Win
    modkey = "Mod1" -- Alt


-- Table of layouts to cover with awful.layout.inc, order matters.
    awful.layout.layouts = {
        awful.layout.suit.tile.left,
        awful.layout.suit.floating,
    --    awful.layout.suit.tile,
    --    awful.layout.suit.tile.bottom,
    --    awful.layout.suit.tile.top,
    --    awful.layout.suit.fair,
    --    awful.layout.suit.fair.horizontal,
    --    awful.layout.suit.spiral,
    --    awful.layout.suit.spiral.dwindle,
    --    awful.layout.suit.max,
    --    awful.layout.suit.max.fullscreen,
    --    awful.layout.suit.magnifier,
    --    awful.layout.suit.corner.nw,
    --    awful.layout.suit.corner.ne,
    --    awful.layout.suit.corner.sw,
    --    awful.layout.suit.corner.se,
    }
-- }}}


------------------------------------------------
------------------- WIDGETS --------------------
------------------------------------------------
-- Separator Blanc
    tboxsep1 = wibox.widget.textbox(" ")
    tboxsep2 = wibox.widget.textbox("  ")
    tboxsep3 = wibox.widget.textbox(" ")


-- Keyboard map indicator and switcher
    mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
    mytextclock = wibox.widget.textclock()
    local clock = wibox.widget.background()
    clock:set_widget(mytextclock)
    clock:set_bg("#1a1a1a")
    clock:set_shape(gears.shape.rectangle)


-- Volume
    local volume = awful.widget.watch('/home/filipe/.config/scripts/wibar/volume-wibox')
    local volumew = wibox.widget.background()
    volumew:set_widget(volume)
    volumew:set_bg("#1a1a1a")
    volumew:set_shape(gears.shape.rectangle)

-- Cpu
    local cpu = awful.widget.watch('/home/filipe/.config/scripts/wibar/cpu-wibox')
--local cpuw = wibox.widget.background()
--cpuw:set_widget(cpu)
--cpuw:set_bg("#1a1a1a")
--cpuw:set_shape(gears.shape.rectangle)

-- Disk
    local disk = awful.widget.watch('/home/filipe/.config/scripts/wibar/disk-bar')

-- Updates
    local updates = awful.widget.watch('/home/filipe/.config/scripts/wibar/debian-updates')




-- Ram
    local ram = awful.widget.watch('/home/filipe/.config/scripts/wibar/ram-wibox')
--local ramw = wibox.widget.background()
--ramw:set_widget(ram)
--ramw:set_bg("#1a1a1a")
--ramw:set_shape(gears.shape.rectangle)

-- Wheather
    local weather = awful.widget.watch('/home/filipe/.config/scripts/wibar/weather-wibox')
--local weatherw = wibox.widget.background()
--weatherw:set_widget(weather)
--weatherw:set_bg("#1a1a1a")
--weatherw:set_shape(gears.shape.rectangle)

-- Updates
    local update = awful.widget.watch('/home/filipe/.config/scripts/wibar/updates-wibox')
    local updatew = wibox.widget.background()
    updatew:set_widget(update)
    updatew:set_bg("#1a1a1a")
    updatew:set_shape(gears.shape.rectangular_tag)



------------------------------------------------
-------------------- WIBAR ---------------------
------------------------------------------------


-- {{{ Menu
-- Create a launcher widget and a main menu
    myawesomemenu = {
       { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
       { "manual", terminal .. " -e man awesome" },
       { "edit config", editor_cmd .. " " .. awesome.conffile },
       { "restart", awesome.restart },
       { "quit", function() awesome.quit() end },
    }

    local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
    local menu_terminal = { "open terminal", terminal }

    if has_fdo then
        mymainmenu = freedesktop.menu.build({
            before = { menu_awesome },
            after =  { menu_terminal }
        })
    else
        mymainmenu = awful.menu({
            items = {
                      menu_awesome,
                      { "Debian", debian.menu.Debian_menu.Debian },
                      menu_terminal,
                    }
        })
    end


    mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
    menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
    mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
    mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
    local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

    local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = false
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))
-- Wallpaper
    local function set_wallpaper(s)

        if beautiful.wallpaper then
            local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
            if type(wallpaper) == "function" then
                wallpaper = wallpaper(s)
            end
            gears.wallpaper.maximized(wallpaper, s, true)
        end
    end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
    screen.connect_signal("property::geometry", set_wallpaper)

    awful.screen.connect_for_each_screen(function(s)
-- Wallpaper
    set_wallpaper(s)

-- Each screen has its own tag table.
    awful.tag({ "I","II","III","IV","V" }, s, awful.layout.layouts[1])

-- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
-- Create an imagebox widget which will contain an icon indicating which layout we're using.
-- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
-- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

-- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.focused,
        --filter  = awful.widget.tasklist.filter.currenttags,
        --buttons = tasklist_buttons
    }

-- Create the wibox
-- "top" em cima
-- "bottom" em baixo
    s.mywibox = awful.wibar({ position = "top", screen = s, visible = true })

-- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,


         { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            tboxsep,
            --tboxsep,
            cpu,
            ram,
            disk,
            weather,
            updates,
            tboxsep2,
            tboxsep4,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,

            --tboxsep2,
            mykeyboardlayout,
            --volumecfg.widget,
            volume,
            --tboxsep3,
            mytextclock,
            --tboxsep3,
            --wibox.widget.systray(),
            {
                widget = wibox.widget.systray,
                base_size = 26,
                horizontal = true,
            },
            s.mylayoutbox,
        },
    }
end)
-- }}}


------------------------------------------------
----------------- KEYBINDINGS ------------------
------------------------------------------------

-- {{{ Key bindings
globalkeys = gears.table.join(

    -- Standard Program
    awful.key({ modkey,           }, "F1" , function () awful.spawn(browser) end,
    	      {description = "open a browser", group = "launcher"}),

    awful.key({ modkey,           }, "F2" , function () awful.spawn(fm) end,
    	      {description = "open a file manager", group = "launcher"}),

    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),

    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),

    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey         },   "a",    function () awful.spawn("alacritty -e pulsemixer") end,
    	{description = "Exec pulsemixer", group = "Personal launchers"}),


    awful.key({ modkey         },   "b",    function () awful.spawn("blueman-manager") end,
    	{description = "Exec pulsemixer", group = "Personal launchers"}),


    awful.key({ modkey,         },  "s",    function () awful.spawn("alacritty -e ranger") end,
        {descrption = "Open ranger", group = "Personal launchers"}),

    awful.key({ "Control",         },   "space",    function () awful.spawn("rofi -show drun -display-drun ' Exec ' ") end,
        {description = "Rofi-apps", group = "Personal launchers"}),

    awful.key({ modkey,         },   "Tab",      function () awful.spawn("rofi -show window ' Exec ' ") end,
        {description = "Rofi-switch-apps", group = "Personal launchers"}),

    awful.key({ modkey         },   "t",      function () awful.spawn("alacritty -e htop") end,
        {description = "Open htop", group = "Personal launchers"}),

    awful.key({ modkey         },   "r",        function () awful.spawn("/home/filipe/.config/scripts/rofi/rofi-files") end,
        {description = "Search files", group = "Personal launchers"}),

    awful.key({ modkey         },   "p",        function () awful.spawn("/home/filipe/.config/scripts/rofi/rofi-search") end,
    	{description = "Rofi-search", group = "Personal launchers"}),

 awful.key({ modkey         },   "x",        function () awful.spawn("/home/filipe/.config/scripts/rofi/power-menu.sh") end,
    	{description = "Power-menu.sh", group = "Personal launchers"}),




    awful.key({ "Control"         },   "Up",      function () awful.spawn("/home/filipe/.config/scripts/notify/volume+") end,
        {description = "exec volup", group = "Personal launchers"}),

    awful.key({ "Control"         },   "Down",      function () awful.spawn("/home/filipe/.config/scripts/notify/volume-") end,
        {descritipn = "exec voldown", group = "Personal launchers"}),

    awful.key({ "Control", "Shift"          }, "h",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

-- Control Clients

    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),

    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),

    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),

    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

--    awful.key({ modkey,           }, "Tab",
  --      function ()
    --        awful.client.focus.history.previous()
      --      if client.focus then
        --        client.focus:raise()
          --  end
       -- end,
        --{description = "go back", group = "client"}),



    -- Control Clients
    awful.key({ "Control",           }, "j",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),

    awful.key({ "Control",           }, "k",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),



    awful.key({ modkey, 	  }, "n",  awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}),


    -- Layout Manipulation

    awful.key({ modkey,           }, "Left", function () awful.client.focus.byidx( 1) end,
        {description = "focus next by index", group = "client"}),

    awful.key({ modkey,          }, "Right", function () awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client"}),

    awful.key({ modkey, "Shift"   }, "Right", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),

    awful.key({ modkey, "Shift"   }, "Left", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),

    awful.key({ modkey, "Control"          }, "Left",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),

    awful.key({ modkey, "Control"          }, "Right",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),



    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),

    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),

    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),


    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),



    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),



    -- Prompt
    awful.key({ modkey },            "F6",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "l",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "--", function() menubar.show() end,
             {description = "show the menubar", group = "launcher"})

         )

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),

-- Close Clients
    awful.key({ modkey,    }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),



    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey           }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
    root.keys(globalkeys)
-- }}}
    local function client_status(client)

        local layout = awful.layout.get(mouse.screen)

        if (layout == awful.layout.suit.floating) or (client and client.floating) then
            return "floating"
        end

        if layout == awful.layout.suit.max then
            return "max"
        end

        return "other"

    end


------------------------------------------------
-------------------- RULES ---------------------
------------------------------------------------

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}


-------------------------------------------------
-------------------- SIGNALS --------------------
-------------------------------------------------

-- {{{ Signals
-- Signal function to execute when a new client appears.
    client.connect_signal("manage", function (c)
    -- Set the windows at the slave,

        if awesome.startup
          and not c.size_hints.user_position
          and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
    end)


-- Enable sloppy focus, so that focus follows mouse.
    client.connect_signal("mouse::enter", function(c)
        c:emit_signal("request::activate", "mouse_enter", {raise = false})
    end)

    client.connect_signal("focus", function(c)
        c.border_color = beautiful.border_focus end)
    client.connect_signal("unfocus", function(c)
        c.border_color = beautiful.border_normal end)
-- }}}

--------------------------------------------------
--------------------- GAPS ----------------------
--------------------------------------------------

    beautiful.useless_gap = 4,

-- beautiful.gap_single_client   = false

-- No borders when rearranging only 1 non-floating or maximized client
--  screen.connect_signal("arrange", function (s)
--    local only_one = #s.tiled_clients == 1
--    for _, c in pairs(s.clients) do
--        if only_one and not c.floating or c.maximized then
--            c.border_width = 0
--        else
--            c.border_width = 1 -- your border width
--        end
--    end
--end)

--------------------------------------------------
----------------- AUTOSTART ----------------------
--------------------------------------------------
    --awful.spawn.with_shell('flameshot') --bater print
    awful.spawn.with_shell('nitrogen --restore') -- controlador de wallpaper
    awful.spawn.with_shell('blueman-tray') --bluetooth
    awful.spawn.with_shell('xset s off') -- para não desligar a tela
    awful.spawn.with_shell('xset r rate 300 50')
    awful.spawn.with_shell('xrandr -r 144') -- monitor 144hz
    awful.spawn.with_shell('xset -dpms')
    awful.spawn.with_shell('setxkbmap us alt-intl') -- teclado Ansi
    awful.spawn.with_shell('picom --experimental-backends') --background transluced
    awful.spawn.with_shell('parcellite') --gerenciador de área de transferencia
    awful.spawn.with_shell('knotes') --gerenciador de área de transferencia

