-- Debdeep Bhattacharya
-- 2018-02-12
-- Update: has dmenu! 
-- 
-- Plan: use vicious instead of lain
-- Use colored text and bar/graph instead of icons
-- Simple code structure
-- Convertible-friendly
--
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
--consider disabling menubar and debain menu
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Load Debian menu entries
require("debian.menu")

--vicious library for graph, bar etc
local vicious = require("vicious")

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

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
--
--beautiful.init(awful.util.get_themes_dir() .. "default/theme.lua")
beautiful.init("/home/debdeep/.config/awesome/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
-- changing terminal to xterm because of weird gap between xfce4-terminals
-- what can be removed with size_hints_honor=false but it breaks the xfce4-terminal windows
-- sad, I like the Ctrl++ for zoom in in xfce4-terminals, but xterm is too primitive, and does not have nice right click options either
---terminal = "x-terminal-emulator"
--terminal = 'xterm'
terminal = 'xfce4-terminal'
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor


------------ startup applications ---------------------------
-- For appearance related perks
-- e.g. Dark theme, nice gtk-based save-as boxes, print dialog
-- Issue: Winkey+numbers shortcuts interfere with xfce shortcuts
-- Fixed: Go to keyboard settings (Alt+F3 > Keyboard) > Shortcuts 
-- and remove all shortcuts with Super+. in it (or, just restore to default will remove most)
-- then Restart (very important) to take effect
-- Issue: Sometimes the touchpad tap and scroll do not work
-- Fixed: Worked after restart
-- Fixed (if restart does not work): 
-- add the line:	Option "Tapping" "True"
-- in the section: Identifier "libinput touchpad catchall"
-- of the file /usr/share/X11/xorg.conf.d/40-libinput.conf
-- Issue: touchpad picks up touch a bit late after staying idle for some time
-- Fixed: after restart
awful.spawn("xfsettingsd")	-- Alt+F3 for apps, 
-- For some reason pulseaudio does not run at startup, found that out by running xfce4-taskmanager.
-- So now manually running it.
-- Fixed: seems that running xfsettingsd fixes this issue
-- Keeping it turned off for now
--awful.spawn("pulseaudio --start --log-target=syslog")
awful.spawn("xfce4-power-manager") --brightness keys

awful.spawn("nm-applet")
-- multiple redshift are slowing down cpu every 5 seconds
-- turn off to see if improves xournal performance over suspend
awful.spawn("redshift")
awful.spawn("onboard") --onscreen keyboard --needs options
-- to freeze the mouse while touching
--awful.spawn("mousefreeze")
------------------------------------------------------------


-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"

-- color related tools
local function txtcol(text,col)
	return '<span color="' .. col .. '">' .. text .. '</span>'
end

---solarized
local base03 =    "#002b36"
local base02 =    "#073642"
local base01 =    "#586e75"
local base00 =    "#657b83"
local base0 =     "#839496"
local base1 =     "#93a1a1"
local base2 =     "#eee8d5"
local base3 =     "#fdf6e3"
local yellow =    "#b58900"
local orange =    "#cb4b16"
local red =       "#dc322f"
local magenta =   "#d33682"
local violet =    "#6c71c4"
local blue =      "#268bd2"
local cyan =      "#2aa198"
local green =     "#859900"


-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "Debian", debian.menu.Debian_menu.Debian },
                                    { "open terminal", terminal }
                                  }
                        })

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


--Use-created widget placements--------------------------

   datewidget = wibox.widget.textbox()
   local datestring = txtcol("%b", base1) .. txtcol("%d", base3) .. txtcol("%a", base1) .. txtcol("%I:%M", base3)
    vicious.register(datewidget, vicious.widgets.date, datestring)


--    -- memwidget = wibox.widget.textbox()
--    --vicious.cache(vicious.widgets.mem)
--    --vicious.register(memwidget, vicious.widgets.mem, "$1%", 5)

   -- -- Create memory wibox 
    memwidget = wibox.widget.progressbar()
    membox = wibox.widget {
    {
        --max_value     = 1,
        widget        = memwidget,
      background_color         = base03,
        color         = blue, 
	border_width  = 0.5,
	--border_color  = base1,
      },
      --forced_height = 10,
      forced_width  = 7,
      direction     = 'east',
      layout        = wibox.container.rotate,
    }
    --membox = wibox.container.margin(membox, 1, 1, 3, 3)
    -- Register memory widget
    vicious.register(memwidget, vicious.widgets.mem, "$1", 7)




-- battery info
   baticon = wibox.widget.textbox()
 vicious.register(baticon, vicious.widgets.bat,
   function(widget, args)
     local batcolor = cyan 
     if args[2] < 10 then
	     batcolor = '#ff1122'
     end
     return txtcol(args[2] .. args[1],batcolor)  
   end, 29, "BAT1")

    baticon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.spawn("xfce4-power-manager-settings") vicious.force({baticon})       end)
    --
    ))



-- CPU
    --cpuwidget = awful.widget.graph()
    cpuwidget = wibox.widget.graph()
    cpuwidget:set_width(25)
    cpuwidget:set_background_color("#494B4F")
    cpuwidget:set_color({ type = "linear", from = { 0, 0 }, to = { 50, 0 },
      stops = { { 0, red }, { 0.5, orange }, { 1, green }}})

    vicious.register(cpuwidget, vicious.widgets.cpu, "$1", 5)

	cpuwidget:buttons(awful.util.table.join(
	awful.button({ }, 1, function () awful.spawn("xfce4-taskmanager") end)
	))

-- volume
 volumewidget = wibox.widget.progressbar()

-- vicious.register(volumewidget, vicious.widgets.volume,
--   function(widget, args)
--     local volcolor = '#889900'
--     --local label = { ["♫"] = "O", ["♩"] = "M" }
--     if args[2] == "♩" then
--	     volcolor = '#ff1122'
--     end
--     return txtcol(args[1],volcolor) --..  args[2]
--   end, 29, "Master")


volbox = wibox.widget {
	{
		widget        = volumewidget,
		background_color = base00,
		--color         = green,
		border_width  = 0.5,
		border_color  = base2,
	},
	--forced_height = 10,
	forced_width  = 20,
	direction     = 'east',
	layout        = wibox.container.rotate,
}
--membox = wibox.container.margin(membox, 1, 1, 3, 3)
-- Register memory widget
vicious.register(volumewidget, vicious.widgets.volume, function(widget, args)
	if args[2] == "♩" then 
		volumewidget:set_color(orange)
	else
		volumewidget:set_color(green)
	end
	return args[1]
end, 29, "Master")

-- volcontrol is a myscr script, check if exists
volumewidget:buttons(awful.util.table.join(
--awful.button({ }, 4, function () awful.spawn("amixer -q set Master 5%+") vicious.force({volumewidget})       end),
awful.button({ }, 4, function () awful.spawn("volcontrol +5%") vicious.force({volumewidget})       end),
awful.button({ }, 5, function () awful.spawn("volcontrol -5%") vicious.force({volumewidget})       end),
-- added one more update ( vicious.force ) for the volumewidget so that it captures the muted state properly
awful.button({ }, 1, function () awful.spawn("volcontrol mute") vicious.force({volumewidget})  vicious.force({volumewidget}) end),
awful.button({ }, 3, function () awful.spawn("pavucontrol") vicious.force({volumewidget}) end)
))       


---Convertible options

--Touchscreen
touch = wibox.widget.textbox("↺ ")
touch:buttons(awful.util.table.join(
 awful.button({ }, 1, function () awful.spawn("xterm -e toggle-rotate.sh") end)
 ))       

--Auto-change brightness
light = wibox.widget.textbox("☼ ")
light:buttons(awful.util.table.join(
awful.button({ }, 1, function () awful.spawn("lumi") end),
awful.button({ }, 4, function () awful.spawn("xbacklight -inc 3")  end),
awful.button({ }, 5, function () awful.spawn("xbacklight -dec 3")  end)
 ))       

--Record light data
recdata = wibox.widget.textbox("✎ ")
recdata:buttons(awful.util.table.join(
 awful.button({ }, 1, function () awful.spawn("recordlightval.sh") end)
 ))       

 -- restart the input devices
 reinput = wibox.widget.textbox(" △ ")
 reinput:buttons(awful.util.table.join(
  awful.button({}, 1, function () awful.spawn("xterm -e reinput") end)
  ))

--options for restarting the input devices in case they malfunction in convertible mode

-- drop-down attachment for widgets and dbus message

-----------------------------------------------

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
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

local tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
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
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    -- added the height parameter for the wibox panel height
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 22})

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --mylauncher, --no need for the menu bar
            s.mylayoutbox,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            --mytextclock,
--cgraph,
--volumewidget,
reinput,
touch,
recdata,
light,
volbox,
cpuwidget,
membox,
--batbox,
baticon,
datewidget,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(

-----User defined keys----------
    awful.key({ modkey, "Shift" }, "f", function () awful.spawn("firefocusl") end),
--requires slock
awful.key({ "Control", altkey }, "l", function () awful.spawn("lockscreen") end),
    --calendar.vim
    awful.key({ altkey, }, "c", function () awful.spawn(terminal .. " -e vim +Calendar") end),
    -- for xournal
    awful.key({ modkey, "Shift" }, "x", function () awful.spawn("xournal") end),
    -- for Write, a xournal alternative, not open source but free, development stopped, not a good path
    awful.key({ modkey, "Shift" }, "w", function () awful.spawn("/home/debdeep/Downloads/Write/Write") end),
-- screen rotation
    awful.key({ "Control", altkey }, "Left", function () awful.spawn("rotate left") end),
    awful.key({ "Control", altkey }, "Right", function () awful.spawn("rotate right") end),
    awful.key({ "Control", altkey }, "Up", function () awful.spawn("rotate normal") end),
    awful.key({ "Control", altkey }, "Down", function () awful.spawn("rotate inverted") end),
-- launch  file browser
    awful.key({ modkey }, "e", function () awful.spawn(terminal .. " -e ranger") end),
-- dmenu!!!!!
-- probably requires dwm
    awful.key({ modkey }, "d", function ()
        awful.spawn(string.format("dmenu_run -i -fn 'Monospace' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
        beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
		end),

    -- volume control
    awful.key({ altkey }, "Up",
        function ()
            os.execute("pactl set-sink-volume 0 +5%")
		vicious.force({volumewidget,})
        end),
    awful.key({ altkey }, "Down",
        function ()
            os.execute("pactl set-sink-volume 0 -5%")
		vicious.force({volumewidget,})
        end),
    awful.key({ altkey }, "m",
        function ()
            os.execute("pactl set-sink-mute 0 toggle")
		vicious.force({volumewidget,})
        end), 
----------------------------------
-- dynamic tagging
-- taken from lain util init.lua, modified: delete function name and put inside qwful.key
-- renaming a taglist
awful.key({ modkey,  }, "F2",
              function ()
                    awful.prompt.run {
                      prompt       = "Rename: ",
                      text         = awful.tag.selected().name,
                      textbox      = awful.screen.focused().mypromptbox.widget,
                      exe_callback = function (s) awful.tag.selected().name = s end,
                  }
            end,
            {description = "rename tag", group = "awesome"}),

-- Add a new tag
awful.key({ modkey, "Shift"  }, "n",
function ()
    awful.prompt.run {
        prompt       = "New tag: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = function(name)
            if not name or #name == 0 then return end
            awful.tag.add(name, { screen = awful.screen.focused(), layout = layout or awful.layout.suit.tile }):view_only()
        end,
    }
end,
            {description = "add new tag", group = "awesome"}),

-- Delete current tag
-- Any rule set on the tag shall be broken
awful.key({ modkey, "Shift"  }, "d",
function ()
    local t = awful.screen.focused().selected_tag
    if not t then return end
    t:delete()
end,

            {description = "delete current tag", group = "awesome"}),
-- }}}



---- Dynamic tagging
---- requires lain
--awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end),
--awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end),
--awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end),  -- move to previous tag
--awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end),  -- move to next tag
--awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end),
---------------------------------------



    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ altkey,           }, "j",  --changed here
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ altkey,           }, "k",  --changed here
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
-- Addition to keys----------------
 -- By direction client focus-
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "h",	--interfares with default
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "l",  --interfares with default 
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),

 -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end),


----------------------------------
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
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
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ altkey, "Shift"           }, "l",     function () awful.tag.incmwfact( 0.05)          end, --changed here
              {description = "increase master width factor", group = "layout"}),
    awful.key({ altkey, "Shift"          }, "h",     function () awful.tag.incmwfact(-0.05)          end, 	--changed here
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
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
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
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
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
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
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

clientbuttons = awful.util.table.join(
    ----rename the button-1 click behaviour for onboard
    --awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    -- To stop focusing on onboard on Left click
    awful.button({ }, 1, 
    	function (c) 
	  if c.class ~= "Onboard" 
	    then client.focus = c 
	  end 
	  c:raise() 
	end),
    ---------------
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

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
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
		     -- to remove small gaps between windows, something like useless gaps
		     -- but this breaks xfce4-terminal :(
		      size_hints_honor = false
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
    -- Set Firefox to always map on the first tag on screen 1.
    { rule = { class = "Firefox" },
      properties = { screen = 1, tag = screen[1].tags[4] } },

    { rule = { class = "Gimp", role = "gimp-image-window" },
          properties = {} },
  -- Start windows as slave by default
  { rule = { }, properties = { }, callback = awful.client.setslave },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
