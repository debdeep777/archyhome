--[[

     Powerarrow Awesome WM theme
     github.com/lcpz

--]]
-- Changes are marked with -- Debdeep



local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow"
theme.wallpaper                                 = theme.dir .. "/wall.png"
-- Debdeep
theme.font                                      = "DejaVu 12"
theme.font_small                                      = "DejaVu 10"
theme.font_mono                                 = "DejaVu Sans Mono 12"
theme.fg_normal                                 = "#FEFEFE"
theme.fg_focus                                  = "#32D6FF"
theme.fg_urgent                                 = "#C83F11"
theme.bg_normal                                 = "#222222"
theme.bg_focus                                  = "#3F4522"
theme.bg_urgent                                 = "#CB755B"
theme.taglist_fg_focus                          = "#00CCFF"
theme.tasklist_bg_focus                         = "#222222"
theme.tasklist_fg_focus                         = "#00CCFF"
theme.border_width                              = 1
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#6F6F6F"
theme.border_marked                             = "#CC9393"
theme.titlebar_bg_focus                         = "#3F3F3F"
theme.titlebar_bg_normal                        = "#3F3F3F"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_height                               = 18
theme.menu_width                                = 140
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.awesome_icon                              = theme.dir .. "/icons/awesome.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"

-- Replaced powerarrow-darker/icons by powerarrow/icons
theme.layout_centerwork                           = theme.dir .. "/icons/centerwork.png"
theme.layout_centerworkh                           = theme.dir .. "/icons/centerworkh.png"
theme.layout_centerfair                           = theme.dir .. "/icons/centerfair.png"
theme.layout_termfair                           = theme.dir .. "/icons/termfair.png"
theme.layout_cascadetile                           = theme.dir .. "/icons/floating.png"

theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_music_pause                        = theme.dir .. "/icons/pause.png"
theme.widget_music_stop                         = theme.dir .. "/icons/stop.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.widget_task                               = theme.dir .. "/icons/task.png"
theme.widget_scissors                           = theme.dir .. "/icons/scissors.png"
-- Debdeep
theme.tasklist_plain_task_name                  = false
-- Debdeep
theme.tasklist_disable_icon                     = false
-- Debdeep
theme.tasklist_floating             = "~"  --for some reason, this is the symbol for maximized window, the symbol for floating is ^, where is that setting?
theme.tasklist_maximized = "▪"



theme.useless_gap                               = 0
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

local markup = lain.util.markup
local separators = lain.util.separators

-- quake 
--
local quake = lain.util.quake({ app = awful.util.terminal})


-- Binary clock
local binclock = require("themes.powerarrow.binclock"){
    height = 16,
    show_seconds = true,
    color_active = theme.fg_normal,
    color_inactive = theme.bg_focus
}

-- Textclock 
  local clockicon = wibox.widget.imagebox(theme.widget_clock)
  local clock = awful.widget.watch(
       "date +'%b%d%a %I:%M'", 60,
       function(widget, stdout)
	       widget:set_markup(" " .. markup.font(theme.font, stdout))
       end
	)  

-- My Textclock
local datestring = markup.font(theme.font_small, markup("#002b36", " %b ")) .. markup.font(theme.font, markup("#FFFFFF","%d "))  
local timestring = markup.font(theme.font_small, markup("#DB856B", "%a ")) .. markup.font(theme.font, markup("#FFFFFF", "%I:%M" ))
local mydate = wibox.widget.textclock(datestring)
local mytime = wibox.widget.textclock(timestring)
mydate:buttons(awful.util.table.join(awful.button({}, 1, function () awful.spawn.with_shell("zenity --calendar --text=") end )))



-- Calendar
theme.cal = lain.widget.cal({
    --cal = "cal --color=always",
    attach_to = { binclock.widget },
    notification_preset = {
        font = "xos4 Terminus 10",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- Taskwarrior
local task = wibox.widget.imagebox(theme.widget_task)
lain.widget.contrib.task.attach(task, {
    -- do not colorize output
    --show_cmd = "task | sed -r 's/\\x1B\\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g'"
    show_cmd = "cat .todo"
})
task:buttons(my_table.join(awful.button({}, 1, lain.widget.contrib.task.prompt)))


-- Scissors (xsel copy and paste)
local scissors = wibox.widget.imagebox(theme.widget_scissors)
scissors:buttons(my_table.join(awful.button({}, 1, function() awful.spawn.with_shell("xsel | xsel -i -b") end)))

-- Mail IMAP check
--[[ commented because it needs to be set before use
local mailicon = wibox.widget.imagebox(theme.widget_mail)
mailicon:buttons(my_table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            widget:set_text(" " .. mailcount .. " ")
            mailicon:set_image(theme.widget_mail_on)
        else
            widget:set_text("")
            mailicon:set_image(theme.widget_mail)
        end
    end
})
--]]

-- pulse volume
-- Consider using pulsebar from lain library
-- Uses pactl as mine be has better control
theme.volumebar = lain.widget.pulsebar({
 width = 40,
margins = 2,
--colors = {
--background = "#343434", 
	--unmute = '#ffffff', 
	--mute = '#CB755B',
--},
ticks_size = 5,
paddings = 0,
ticks = true,
--margins = 0,
    --togglechannel = "IEC958,3",
	--default width=63
    --notification_preset = { font = theme.font, fg = theme.fg_normal, bg=theme.bf_normal },
})

local volume = wibox.container.background(theme.volumebar.bar)
theme.volumebar.bar:buttons(awful.util.table.join(                                                
-- myscr script volcontrol, uses pactl, chooses the main sound card
 awful.button({ }, 4, function () awful.spawn("pactl set-sink-volume 0 +5%") theme.volumebar.update()       end),
 awful.button({ }, 5, function () awful.spawn("pactl set-sink-volume 0 -5%")  theme.volumebar.update()      end),
 awful.button({ }, 1, function () awful.spawn("pactl set-sink-mute 0 toggle")  theme.volumebar.update() end),
 awful.button({ }, 3, function () awful.spawn("pavucontrol")      end)   
 ))  

-- Weather                                                                                                                                                                                 
   theme.weather = lain.widget.weather({
	-- Taken from https://openweathermap.org/
	-- Search for city, click on the city and look at the address bar the code
	city_id = 4366164,  -- washington, DC
       --city_id = 2643743, -- placeholder (London)
       notification_preset = { font = theme.font },
       settings = function()
           units = math.floor(weather_now["main"]["temp"])
           --widget:set_markup(" " .. markup.font(theme.font_mono, units .. "°C") .. " ")
           widget:set_markup(" " .. markup.font(theme.font_small, units) .. " ")
       end
   })
-- Attaching the weather widget
-- Decided not to
-- theme.weather.attach(clock)


-- Downloaded CPU widget
local cpu_widget = require("awesome-wm-widgets.cpu-widget")


-- MPD
local musicplr = awful.util.terminal .. " -title Music -g 130x34-320+16 -e ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(my_table.join(
    awful.button({ modkey }, 1, function () awful.spawn.with_shell(musicplr) end),
    awful.button({ }, 1, function ()
        os.execute("mpc prev")
        theme.mpd.update()
    end),
    awful.button({ }, 2, function ()
        os.execute("mpc toggle")
        theme.mpd.update()
    end),
    awful.button({ }, 3, function ()
        os.execute("mpc next")
        theme.mpd.update()
    end)))
--
theme.mpd = lain.widget.mpd({
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            mpdicon:set_image(theme.widget_music_on)
            widget:set_markup(markup.font(theme.font, markup("#FF8466", artist) .. " " .. title))
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font(theme.font, " mpd paused "))
            mpdicon:set_image(theme.widget_music_pause)
        else
            widget:set_text("")
            mpdicon:set_image(theme.widget_music)
        end
    end
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        --widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
        widget:set_markup(markup.font(theme.font_small, " " .. cpu_now.usage .." "))
    end
})
--cpu:buttons(awful.util.table.join(
--awful.button({ }, 1, function () awful.spawn("xfce4-power-manager-settings") end),
--awful.button({ }, 4, function () awful.spawn("xbacklight -inc 3")  end),
--awful.button({ }, 5, function () awful.spawn("xbacklight -dec 3")  end)
-- ))       

--[[ Coretemp (lm_sensors, per core)
local tempwidget = awful.widget.watch({awful.util.shell, '-c', 'sensors | grep Core'}, 30,
function(widget, stdout)
    local temps = ""
    for line in stdout:gmatch("[^\r\n]+") do
        temps = temps .. line:match("+(%d+).*°C")  .. "° " -- in Celsius
    end
    widget:set_markup(markup.font(theme.font, " " .. temps))
end)
--]]
-- Coretemp (lain, average)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
    end
})
--]]
local tempicon = wibox.widget.imagebox(theme.widget_temp)

-- / fs
local fsicon = wibox.widget.imagebox(theme.widget_hdd)
--[[ commented because it needs Gio/Glib >= 2.54
theme.fs = lain.widget.fs({
    notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "xos4 Terminus 10" },
    settings = function()
        local fsp = string.format(" %3.2f %s ", fs_now["/"].free, fs_now["/"].units)
        widget:set_markup(markup.font(theme.font, fsp))
    end
})
--]]

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                widget:set_markup(markup.font(theme.font, " AC "))
                baticon:set_image(theme.widget_ac)
                return
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image(theme.widget_battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image(theme.widget_battery_low)
            else
                baticon:set_image(theme.widget_battery)
            end
            --widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
            widget:set_markup(markup.font(theme.font_small, bat_now.perc .. " "))
        else
            widget:set_markup()
            baticon:set_image(theme.widget_ac)
        end
    end
})
-- brightness and power manager
bat.widget:buttons(awful.util.table.join(
awful.button({ }, 1, function () awful.spawn("xfce4-power-manager-settings") end),
awful.button({ }, 4, function () awful.spawn("xbacklight -inc 3")  end),
awful.button({ }, 5, function () awful.spawn("xbacklight -dec 3")  end)
 ))       


-- Net
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#FEFEFE", " " .. net_now.received .. " ↓↑ " .. net_now.sent .. " "))
    end
})

-- Separators
local arrow = separators.arrow_left

function theme.powerline_rl(cr, width, height)
    local arrow_depth, offset = height/2, 0

    -- Avoid going out of the (potential) clip area
    if arrow_depth < 0 then
        width  =  width + 2*arrow_depth
        offset = -arrow_depth
    end

    cr:move_to(offset + arrow_depth         , 0        )
    cr:line_to(offset + width               , 0        )
    cr:line_to(offset + width - arrow_depth , height/2 )
    cr:line_to(offset + width               , height   )
    cr:line_to(offset + arrow_depth         , height   )
    cr:line_to(offset                       , height/2 )

    cr:close_path()
end

local function pl(widget, bgcolor, padding)
    return wibox.container.background(wibox.container.margin(widget, 16, 16), bgcolor, theme.powerline_rl)
end

function theme.at_screen_connect(s)
    -- Quake application
    --s.quake = lain.util.quake({ app = awful.util.terminal })
    --s.quake = lain.util.quake({ app = "xfce4-terminal", argname = "--name %s" })
    s.quake = lain.util.quake()

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 16, bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            wibox.container.background(wibox.container.margin(s.mylayoutbox, 0, 0),"#4b696B"),
            s.mytaglist,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            --wibox.container.margin(scissors, 4, 8),
            --[[ using shapes
            pl(wibox.widget { mpdicon, theme.mpd.widget, layout = wibox.layout.align.horizontal }, "#343434"),
            pl(task, "#343434"),
            --pl(wibox.widget { mailicon, mail and theme.mail.widget, layout = wibox.layout.align.horizontal }, "#343434"),
            pl(wibox.widget { memicon, mem.widget, layout = wibox.layout.align.horizontal }, "#777E76"),
            pl(wibox.widget { cpuicon, cpu.widget, layout = wibox.layout.align.horizontal }, "#4B696D"),
            pl(wibox.widget { tempicon, temp.widget, layout = wibox.layout.align.horizontal }, "#4B3B51"),
            --pl(wibox.widget { fsicon, theme.fs and theme.fs.widget, layout = wibox.layout.align.horizontal }, "#CB755B"),
            pl(wibox.widget { baticon, bat.widget, layout = wibox.layout.align.horizontal }, "#8DAA9A"),
            pl(wibox.widget { neticon, net.widget, layout = wibox.layout.align.horizontal }, "#C0C0A2"),
            pl(binclock.widget, "#777E76"),
            --]]
	    --
            -- using separators
            -- arrow(theme.bg_normal, "#343434"),
            -- wibox.container.background(wibox.container.margin(wibox.widget { mailicon, theme.mail and theme.mail.widget, layout = wibox.layout.align.horizontal }, 4, 7), "#343434"),
	    -- MPD
            --arrow("#343434", theme.bg_normal),
            --wibox.container.background(wibox.container.margin(wibox.widget { mpdicon, theme.mpd.widget, layout = wibox.layout.align.horizontal }, 3, 6), theme.bg_focus),
	--volume
	--volume,
	cpu_widget,
	    -- task 
            --arrow(theme.bg_normal, "#343434"),
            wibox.container.background(wibox.container.margin(task, 3, 7), "#343434"),
	--volumebar,
            wibox.container.background(wibox.container.margin(theme.volumebar.bar, 3, 7), "#343434"),
            --wibox.container.background(wibox.container.margin(wibox.widget { theme.volumebar.bar, layout = wibox.layout.align.horizontal }, 3, 6), theme.bg_focus),
	    -- memory
            --arrow("#343434", "#777E76"),
            --wibox.container.background(wibox.container.margin(wibox.widget { memicon, mem.widget, layout = wibox.layout.align.horizontal }, 2, 3), "#777E76"),
	    -- cpu
            arrow("#343434", "#777e76"),
            wibox.container.background(wibox.container.margin(wibox.widget {cpu.widget, layout = wibox.layout.align.horizontal }, 0, 0), "#777e76"),


	    -- temp
            --arrow("#4B696D", "#4B3B51"),
            --wibox.container.background(wibox.container.margin(wibox.widget { tempicon, temp.widget, layout = wibox.layout.align.horizontal }, 4, 4), "#4B3B51"),
	    -- filesystem
            --wibox.container.background(wibox.container.margin(wibox.widget { fsicon, theme.fs and theme.fs.widget, layout = wibox.layout.align.horizontal }, 3, 3), "#CB755B"),
	    -- bat
           arrow("#777e76", "#CB755B"),
            --wibox.container.background(wibox.container.margin(wibox.widget { baticon, bat.widget, layout = wibox.layout.align.horizontal }, 3, 3), "#4b696d"),
          -- wibox.container.background(wibox.container.margin(wibox.widget { baticon, bat.widget, layout = wibox.layout.align.horizontal }, 0, 0), "#4b696d"),
           wibox.container.background(wibox.container.margin(wibox.widget { bat.widget, layout = wibox.layout.align.horizontal }, 0, 0), "#CB755B"),

	--weather
            arrow("#CB755B", "#4b696d"),
           wibox.container.background(wibox.container.margin(wibox.widget {  theme.weather.widget, theme.weather.icon, layout = wibox.layout.align.horizontal }, 0, 0), "#4b696d"),

	    -- data
            --arrow("#8DAA9A", "#C0C0A2"),
            --wibox.container.background(wibox.container.margin(wibox.widget { nil, neticon, net.widget, layout = wibox.layout.align.horizontal }, 3, 3), "#C0C0A2"),
	    -- clock
            arrow("#4b696d", "#777e76"),
            wibox.container.background(wibox.container.margin(wibox.widget {mydate, layout = wibox.layout.align.horizontal }, 0, 0), "#777e76"),
            arrow("#777e76", "#4B3B51"),
            --wibox.container.background(wibox.container.margin(binclock.widget, 4, 8), "#777E76"),
            wibox.container.background(wibox.container.margin(mytime, 1, 1), "#4B3B51"),
            --]]
        },
    }
end

return theme
