-- Modified by me
-- Based on the Multicolor theme by copycat-killer at github
-- using all Te variables from awesome/theme/multicolor/theme.lua

-- {{{ Required libraries
local gears     = require("gears")
local awful     = require("awful")
awful.rules     = require("awful.rules")
require("awful.autofocus")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local drop      = require("scratchdrop")	-- Only for the dropdown terminal
local lain      = require("lain")
local redshift = require("redshift")		-- the package redshift has to be installed also

local vicious =  require("vicious")		-- the package must be installed "pacman -S vicious"
-- }}}

-- launching redshift in the beginning
-- 1 for dim, 0 for not dimmed
redshift.init(1)

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart applications
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

run_once("dhcpcd")
run_once("unclutter")
run_once("storage")
-- temporary for rtorrent coz disk space is low
run_once("otherlin")
--run_once("firefoxspot")
--run_once("wifi")
-- }}}


-- {{{ Variable definitions
-- localization
os.setlocale(os.getenv("LANG"))

-- beautiful inti
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/multicolor/theme.lua")


-- My pop-up text function
-- kept it after beautiful.init, hence they inherit the bg, fg, font etc from
-- the theme file, don't know how though
-- so, why not fg?
-- maybe make it transparent?
-- make it have terminal colors... too much to ask?
function popup(sometitle, sometext)
naughty.notify({
	title = sometitle,
        text = sometext,
--        icon = calendar.notify_icon,
--        position = calendar.position,
--        fg = "#FFFFFF",
--        bg = "#000000",
--	  timeout = 5
    })
end
-- usage:
--popup("helllooo","Theese are the texts")

-- Runs a shell script and return its output
-- very useful
function run_get(shellcommand)
	local f, c_text
	f = io.popen(shellcommand)
	c_text = f:read("*all")
	f:close()
	return c_text
end

-- A function to show the output of a shell script in popup
-- is used later for fun
function run_pop(headingtxt,shellcommand)
	popup(headingtxt, run_get(shellcommand))
end
------------------------
------------------------

-- common
modkey     = "Mod4"
altkey     = "Mod1"
terminal   = "xterm"
editor     = os.getenv("EDITOR") or "nano" or "vi"
editor_cmd = terminal .. " -e " .. editor

-- user defined
browser    = "firefox"
browserfocusl = "firefocusl"
launchtodofile = "t"
--browser2   = "iron"
--gui_editor = "gvim"
graphics   = "gimp"
mail       = terminal .. " -e mutt "

local layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.right,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
}
-- }}}

-- {{{ Tags
tags = {
   names = { "1T", "2M", "3D", "4W", "5G", "6O" },
   layout = { layouts[1], layouts[3], layouts[4], layouts[3], layouts[7], layouts[1] }
}
for s = 1, screen.count() do
-- Each screen has its own tag table.
   tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
--menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}


-- {{{ Wibox
markup      = lain.util.markup

-- Textclock
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
mytextclock = awful.widget.textclock(markup("#CCCCff", "%a ") .. markup("#ffffff", "%d ") .. markup("#c7a8ff", "%b") .. markup("#ffffff", " %I:%M %p"))

-- Calendar, attached to the textclock
lain.widgets.calendar:attach(mytextclock, { font_size = 10 })

-- Weather
-- Maybe I'll use it soon, in some months, hopefully
-- Better keep it handy
weathericon = wibox.widget.imagebox(beautiful.widget_weather)
yawn = lain.widgets.yawn(2295420, {
    settings = function()
        widget:set_markup(markup("#00ff33", units .. "°C (" .. forecast:lower() .. ")" ))
    end
})

-- / fs
-- Don't use it usually
-- At least gives me the "running out" warnings
-- Will be useful if I can make a bar
fsicon = wibox.widget.imagebox(beautiful.widget_fs)
fswidget = lain.widgets.fs({
    settings  = function()
        widget:set_markup(markup("#80d9d8", fs_now.used .. "% "))
    end
})

-- Is constantly running firefox not enough?
--[[ Mail IMAP check
-- commented because it needs to be set before use
mailicon = wibox.widget.imagebox()
mailicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(mail) end)))
mailwidget = lain.widgets.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            mailicon:set_image(beautiful.widget_mail)
            widget:set_markup(markup("#cccccc", mailcount .. " "))
        else
            widget:set_text("")
            mailicon:set_image(nil)
        end
    end
})
]]

-- CPU
--cpuicon = wibox.widget.imagebox()
--cpuicon:set_image(beautiful.widget_cpu)
-- I don't need no icon
cpuwidget = lain.widgets.cpu({
    settings = function()
--        widget:set_markup(markup("#e33a6e", cpu_now.usage .. "% "))
	  widget:set_markup(markup("#e33a6e", cpu_now.usage))
    end
})

-- Coretemp
-- Impractical, but can stay
-- What will I do when laptop get hot? Pour water? Sell it?
tempicon = wibox.widget.imagebox(beautiful.widget_temp)
tempwidget = lain.widgets.temp({
    settings = function()
        widget:set_markup(markup("#f1af5f", coretemp_now .. "°C "))
    end
})


-- Battery
-- Useful because I have set it to show different info for different status
baticon = wibox.widget.imagebox(beautiful.widget_batt)
batwidget = lain.widgets.bat({
    settings = function()
    	batperc = bat_now.perc .. "%"
        if bat_now.status == "Discharging" then
		widget:set_markup(markup("#FF0505", bat_now.time))
        else
		widget:set_markup(markup("#00FF33", batperc))
        end
    end
})

-- ALSA volume
-- Good. Only updates on input
volicon = wibox.widget.imagebox(beautiful.widget_vol)
volumewidget = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end
--        widget:set_markup(markup("#7493d2", volume_now.level .. "% "))
	  widget:set_markup(markup("#7493d2", volume_now.level))
    end
})


---- Net 
-- No need anymore, what am I? A bandwidth hogger?
-- Maybe one wifi-signal level display will be nice
-- Or,an IP address, or systemctl restart netctl-auto service shortcut
--netdownicon = wibox.widget.imagebox(beautiful.widget_netdown)
----netdownicon.align = "middle"
--netdowninfo = wibox.widget.textbox()
--netupicon = wibox.widget.imagebox(beautiful.widget_netup)
----netupicon.align = "middle"
--netupinfo = lain.widgets.net({
--    settings = function()
--        widget:set_markup(markup("#e54c62", net_now.sent .. " "))
--        netdowninfo:set_markup(markup("#87af5f", net_now.received .. " "))
--    end
--})


---- MEM
-- Have a better one, a bar
--memicon = wibox.widget.imagebox(beautiful.widget_mem)
--memwidget = lain.widgets.mem({
--    settings = function()
----        widget:set_markup(markup("#e0da37", mem_now.usedperc .. "% "))
--        widget:set_markup(markup("#e0da37", mem_now.usedperc))
--    end
--})


-- Memory usage progress bar
-- This is the one
memvbar = awful.widget.progressbar()
-- Progressbar properties
memvbar:set_width(15)
memvbar:set_height(15)		-- because the wibox height is set to be 15. Check.
memvbar:set_vertical(true)
memvbar:set_background_color("#494B4F")
memvbar:set_border_color("#ffffff")
memvbar:set_color({ type = "linear", from = { 0, 0 }, to = { 0, 15 }, stops = { {0, "#FF1111"}, {0.5, "#FFFF11"}, 
                    {1, "#11FF11"}}})
                    -- Register widget
                    vicious.register(memvbar, vicious.widgets.mem, "$1", 5)


---- Battery bar
-- Although updating takes time, it's bar, so...
bbar = awful.widget.progressbar()
bbar:set_width(8)
bbar:set_height(20)
bbar:set_vertical(true)
bbar:set_background_color('#FF1122')
bbar:set_color('#9CFF33')
vicious.register(bbar, vicious.widgets.bat, "$2", 45, "BAT1")


-- CPU activity graph. 
-- I suspect that it is the avg of all core, not the first one
--  Created 3 more with $2 $3 etc and saw no activity on those 
--  Also, only one is indicative of the others, right?
cpuw = awful.widget.graph()
-- Graph properties
cpuw:set_width(50)
cpuw:set_background_color("#494B4F")
cpuw:set_color({ type = "linear", from = { 0, 0 }, to = { 10,0 }, stops = { {0, "#FF5656"}, {0.5, "#88A175"}, 
                    {1, "#AECF96" }}})
                    -- Register widget
                    vicious.register(cpuw, vicious.widgets.cpu, "$1", 0.5)

-- Buttons for volume widget
-- For mouse-friendly people
-- We have Alt++,-,M, Ctrl+M also
volumewidget:buttons(awful.util.table.join(
awful.button({ }, 4, function () awful.util.spawn("amixer set Master 5+%") volumewidget.update() end),
awful.button({ }, 5, function () awful.util.spawn("amixer set Master 5-%") volumewidget.update() end),
awful.button({ }, 1, function () awful.util.spawn("amixer set Master toggle-mute") volumewidget.update() end)
))


---- MPD
-- Will use only when I learn it
--mpdicon = wibox.widget.imagebox()
--mpdwidget = lain.widgets.mpd({
--    settings = function()
--        mpd_notification_preset = {
--            text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
--                   mpd_now.album, mpd_now.date, mpd_now.title)
--        }
--
--        if mpd_now.state == "play" then
--            artist = mpd_now.artist .. " > "
--            title  = mpd_now.title .. " "
--            mpdicon:set_image(beautiful.widget_note_on)
--        elseif mpd_now.state == "pause" then
--            artist = "mpd "
--            title  = "paused "
--        else
--            artist = ""
--            title  = ""
--            mpdicon:set_image(nil)
--        end
--        widget:set_markup(markup("#e54c62", artist) .. markup("#b2b2b2", title))
--    end
--})


-- Spacer
-- Don't forget this one
spacer = wibox.widget.textbox(" ")

-- }}}



-- {{{ Layout

-- Create a wibox for each screen and add it
mywibox = {}
--mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()

    
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                            awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                            awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    -- This one is related to task Warrior, inside the contrib widget family
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)
lain.widgets.contrib.task:attach(mytasklist[s])

    -- Create the upper wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 15 }) 
    --border_width = 0, height =  20 })
        
    -- Widgets that are aligned to the upper left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylayoutbox[s])
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])
--    left_layout:add(mpdicon)
--    left_layout:add(mpdwidget)

    -- Widgets that are aligned to the upper right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    --right_layout:add(mailicon)
    --right_layout:add(mailwidget)
--    right_layout:add(netdownicon)
--    right_layout:add(netdowninfo)
--    right_layout:add(netupicon)
--    right_layout:add(netupinfo)
    right_layout:add(volicon)
    right_layout:add(volumewidget)
    right_layout:add(memicon)
    right_layout:add(memwidget)
    right_layout:add(cpuicon)
    right_layout:add(cpuwidget)
--    right_layout:add(fsicon)
--    right_layout:add(fswidget)
--    right_layout:add(weathericon)
--    right_layout:add(yawn.widget)
    right_layout:add(tempicon)
    right_layout:add(tempwidget)
    --right_layout:add(baticon)
    right_layout:add(batwidget)
    right_layout:add(clockicon)
    right_layout:add(mytextclock)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)
    mywibox[s]:set_widget(layout)

-- No need for bottom widget
--    -- Create the bottom wibox
--    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, border_width = 0, height = 20 })
--    --mybottomwibox[s].visible = false
--            
--    -- Widgets that are aligned to the bottom left
--    bottom_left_layout = wibox.layout.fixed.horizontal()
--                        
--    -- Widgets that are aligned to the bottom right
--    bottom_right_layout = wibox.layout.fixed.horizontal()
--    bottom_right_layout:add(mylayoutbox[s])
--                                            
--    -- Now bring it all together (with the tasklist in the middle)
--    bottom_layout = wibox.layout.align.horizontal()
--    bottom_layout:set_left(bottom_left_layout)
--    bottom_layout:set_middle(mytasklist[s])
--    bottom_layout:set_right(bottom_right_layout)
--    mybottomwibox[s]:set_widget(bottom_layout)
end
---- }}}
--
-- {{{ Mouse Bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(

-- Doesn't work  
  -- Take a screenshot
    -- https://github.com/copycat-killer/dots/blob/master/bin/screenshot
--    awful.key({ altkey }, "p", function() os.execute("screenshot") end),

    -- Tag browsing
    awful.key({ modkey }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey }, "Escape", awful.tag.history.restore),

    -- Non-empty tag browsing
    awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end),
    awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end),

    -- Default client focus
    awful.key({ modkey }, "k",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "j",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- By direction client focus
    awful.key({ altkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ altkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ altkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ altkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),

    -- Show Menu
    awful.key({ modkey }, "w",
        function ()
            mymainmenu:show({ keygrabber = true })
        end),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
        mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
        --mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible
    end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
    awful.key({ altkey, "Shift"   }, "l",      function () awful.tag.incmwfact( 0.05)     end),
    awful.key({ altkey, "Shift"   }, "h",      function () awful.tag.incmwfact(-0.05)     end),


    -- Standard program
    awful.key({ modkey, "Shift"   }, "l",      function () awful.tag.incnmaster(-1)       end),
    awful.key({ modkey, "Shift"   }, "h",      function () awful.tag.incnmaster( 1)       end),
    awful.key({ modkey, "Control" }, "l",      function () awful.tag.incncol(-1)          end),
    awful.key({ modkey, "Control" }, "h",      function () awful.tag.incncol( 1)          end),
    awful.key({ modkey,           }, "space",  function () awful.layout.inc(layouts,  1)  end),
    awful.key({ modkey, "Shift"   }, "space",  function () awful.layout.inc(layouts, -1)  end),
    awful.key({ modkey, "Control" }, "n",      awful.client.restore),

    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r",      awesome.restart),
    awful.key({ modkey, "Shift"   }, "q",      awesome.quit),

    -- Dropdown terminal
    awful.key({ modkey,	          }, "z",      function () drop(terminal) end),

    -- Widgets popups
    -- The calendar pop-up
    awful.key({ altkey,           }, "c",      function () lain.widgets.calendar:show(7) end),
    -- The filesystem popup
    -- conflicts with another one
    awful.key({ altkey,           }, "h",      function () fswidget.show(7) end),
    -- The weather popup
    awful.key({ altkey,           }, "w",      function () yawn.show(7) end),

    -- ALSA volume control
    awful.key({ altkey }, "Up",
        function ()
            awful.util.spawn("amixer -q set Master 1%+")
            volumewidget.update()
        end),
    awful.key({ altkey }, "Down",
        function ()
            awful.util.spawn("amixer -q set Master 1%-")
            volumewidget.update()
        end),
    awful.key({ altkey }, "m",
        function ()
            awful.util.spawn("amixer -q set Master playback toggle")
            volumewidget.update()
        end),
    awful.key({ altkey, "Control" }, "m",
        function ()
            awful.util.spawn("amixer -q set Master playback 100%")
            volumewidget.update()
        end),

--    -- MPD control
--    awful.key({ altkey, "Control" }, "Up",
--        function ()
--            awful.util.spawn_with_shell("mpc toggle || ncmpcpp toggle || ncmpc toggle || pms toggle")
--            mpdwidget.update()
--        end),
--    awful.key({ altkey, "Control" }, "Down",
--        function ()
--            awful.util.spawn_with_shell("mpc stop || ncmpcpp stop || ncmpc stop || pms stop")
--            mpdwidget.update()
--        end),
--    awful.key({ altkey, "Control" }, "Left",
--        function ()
--            awful.util.spawn_with_shell("mpc prev || ncmpcpp prev || ncmpc prev || pms prev")
--            mpdwidget.update()
--        end),
--    awful.key({ altkey, "Control" }, "Right",
--        function ()
--            awful.util.spawn_with_shell("mpc next || ncmpcpp next || ncmpc next || pms next")
--            mpdwidget.update()
--        end),

    -- Copy to clipboard
    awful.key({ modkey }, "c", function () os.execute("xsel -p -o | xsel -i -b") end),

    -- User programs
    -- I like to launch my firefox nicely
    awful.key({ modkey, "Shift" }, "f", function () awful.util.spawn(browserfocusl) end),
    -- T want the 'todo new installation' to launch with Mod4+Shift+T
    awful.key({ modkey, "Shift" }, "t", function () awful.util.spawn(launchtodofile) end),
    
    -- Pops up the output after running the "randomscr" script kept in .myscr
    awful.key({ modkey,         }, "q", function ()    run_pop(run_get("cat .myscr/randomscr"),"randomscr")         end),

    -- Takes a screenshot while the print screen button is pressed
    -- Need the package ImageMagick for import 
    awful.key({ }, "Print", function ()  run_pop("Captured Screen to:", "capturescreen") end),
    awful.key({ modkey, "Control" }, "w", function()
    -- Changing wallpaper at will
	-- {{{ Wallpaper
	 --if beautiful.wallpaper then
	     --for s = 1, screen.count() do
--		    gears.wallpaper.maximized(beautiful.wallpaper, s, true)
		    gears.wallpaper.fit(beautiful.wallpaper, 1,black)
	     --end
	 --end
	-- }}}
    											end),

    -- Redshift toggling
    -- config file for redshift is in its usual place, .config/redshift.conf
    awful.key({modkey}, "d", redshift.toggle),

    awful.key({ modkey }, "e", function () awful.util.spawn("xterm -e ranger") end),
    awful.key({ modkey }, "l", function () awful.util.spawn("clock") end),
--    awful.key({ modkey }, "i", function () awful.util.spawn(browser2) end),
    --awful.key({ modkey }, "s", function () awful.util.spawn(gui_editor) end),
    awful.key({ modkey, "Shift" }, "g", function () awful.util.spawn(graphics) end),

    -- Prompt
    awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.toggletag(tag)
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
	                   size_hints_honor = false } },
    { rule = { class = "URxvt" },
          properties = { opacity = 0.99 } },

    { rule = { class = "MPlayer" },
          properties = { floating = true } },

    { rule = { class = "Firefox" },
          properties = { tag = tags[1][4] } },

    { rule = { class = "Chrome" },
          properties = { tag = tags[1][4] } },

    { rule = { class = "Apvlv" },
          properties = { tag = tags[1][3] } },

--    { rule = { class = "Evince" },
--          properties = { tag = tags[1][3] } },

    { rule = { class = "Calibre" },
          properties = { tag = tags[1][1] } },

    { rule = { class = "Dclock" },
--          properties = { floating = true } ,
          properties = { fullscreen = true }},

    { rule = { class = "XClock" },
          properties = { floating = true } ,
   	    properties = { ontop = true  } },

    { rule = { instance = "plugin-container" },
   	    properties = { floating = true  } },
--          properties = { tag = tags[1][2] } },

	  { rule = { class = "Gimp" },
     	    properties = { tag = tags[1][5] } },

    { rule = { class = "Gimp", role = "gimp-image-window" },
          properties = { maximized_horizontal = true,
                         maximized_vertical = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup and not c.size_hints.user_position
       and not c.size_hints.program_position then
        awful.placement.no_overlap(c)
        awful.placement.no_offscreen(c)
    end
end)

-- No border for maximized clients
client.connect_signal("focus",
    function(c)
        if c.maximized_horizontal == true and c.maximized_vertical == true then
            c.border_width = 0
            c.border_color = beautiful.border_normal
        else
            c.border_width = beautiful.border_width
            c.border_color = beautiful.border_focus
        end
    end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Arrange signal handler
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
        local clients = awful.client.visible(s)
        local layout  = awful.layout.getname(awful.layout.get(s))

        if #clients > 0 then -- Fine grained borders and floaters control
            for _, c in pairs(clients) do -- Floaters always have borders
                -- No borders with only one humanly visible client
                if layout == "max" then
                    c.border_width = 0
                elseif awful.client.floating.get(c) or layout == "floating" then
                    c.border_width = beautiful.border_width
                elseif #clients == 1 then 
                    clients[1].border_width = 0
                    if layout ~= "max" then
                        awful.client.moveresize(0, 0, 2, 0, clients[1])
                    end
                else
                    c.border_width = beautiful.border_width
                end
            end
        end
      end)
end
-- }}}
