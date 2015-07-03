--[[
                                      
     Multicolor Awesome WM config 2.0 
     github.com/copycat-killer        
                                      
--]]


theme                               = {}

theme.confdir                       = os.getenv("HOME") .. "/.config/awesome/themes/multicolor"
theme.wallpaper                     = theme.confdir .. "/min.jpg"

-- Main theme font. This gets used in various widget. So, has to be equal width, for example, "DejaVu Sans Mono 10"
theme.font                          = "DejaVu Sans Mono 10"

-- OMG! We can use different fonts for different parts
theme.taglist_font                  = "DejaVu Serif Mono 9"
-- And the tasklist too!
theme.tasklist_font                  = "DejaVu Sans Condensed 10"

theme.menu_bg_normal                = "#000000"
theme.menu_bg_focus                 = "#000000"
theme.fg_minimize                   = "#ffffff"
theme.fg_black                      = "#424242"
theme.fg_red                        = "#ce5666"
theme.fg_green                      = "#80a673"
theme.fg_yellow                     = "#ffaf5f"
theme.fg_blue                       = "#7788af"
theme.fg_magenta                    = "#94738c"
theme.fg_cyan                       = "#778baf"
theme.fg_white                      = "#aaaaaa"
theme.fg_blu                        = "#8ebdde"
theme.border_width                  = "1"
theme.border_normal                 = "#000000"
theme.border_focus                  = "#606060"
theme.border_marked                 = "#3ca4d8"
theme.menu_width                    = "110"
theme.menu_border_width             = "0"
theme.menu_fg_normal                = "#aaaaaa"
theme.menu_fg_focus                 = "#ff8c00"
theme.menu_bg_normal                = "#050505dd"
theme.menu_bg_focus                 = "#050505dd"

theme.colors = {}
theme.colors.base3   = "#1c1c1c"
theme.colors.base2   = "#262626"
theme.colors.base1   = "#585858"
theme.colors.base0   = "#626262"
theme.colors.base00  = "#808080"
theme.colors.base01  = "#8a8a8a"
theme.colors.base02  = "#e4e4e4"
theme.colors.base03  = "#ffffd7"
theme.colors.yellow  = "#af8700"
theme.colors.orange  = "#d75f00"
theme.colors.red     = "#d70000"
theme.colors.magenta = "#af005f"
theme.colors.violet  = "#5f5faf"
theme.colors.blue    = "#0087ff"
theme.colors.cyan    = "#00afaf"
theme.colors.green   = "#5f8700"
-- }}}

-- {{{ Colors
theme.fg_normal  = theme.colors.base02
theme.fg_focus   = theme.colors.base03
theme.fg_urgent  = theme.colors.base3
 
theme.bg_normal  = theme.colors.base3
theme.bg_focus   = theme.colors.base1
theme.bg_urgent  = theme.colors.red
theme.bg_systray = bg_blue
-- }}}

theme.menu_submenu_icon             = theme.confdir .. "/icons/submenu.png"
theme.widget_temp                   = theme.confdir .. "/icons/temp.png"
theme.widget_uptime                 = theme.confdir .. "/icons/ac.png"
theme.widget_cpu                    = theme.confdir .. "/icons/cpu.png"
theme.widget_weather                = theme.confdir .. "/icons/dish.png"
theme.widget_fs                     = theme.confdir .. "/icons/fs.png"
theme.widget_mem                    = theme.confdir .. "/icons/mem.png"
theme.widget_fs                     = theme.confdir .. "/icons/fs.png"
theme.widget_note                   = theme.confdir .. "/icons/note.png"
theme.widget_note_on                = theme.confdir .. "/icons/note_on.png"
theme.widget_netdown                = theme.confdir .. "/icons/net_down.png"
theme.widget_netup                  = theme.confdir .. "/icons/net_up.png"
theme.widget_mail                   = theme.confdir .. "/icons/mail.png"
theme.widget_batt                   = theme.confdir .. "/icons/bat.png"
theme.widget_clock                  = theme.confdir .. "/icons/clock.png"
theme.widget_vol                    = theme.confdir .. "/icons/spkr.png"

theme.taglist_squares_sel           = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel         = theme.confdir .. "/icons/square_b.png"

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = "#"  --for some reason, this is the symbol for maximized window, the symbol for floating is ^, where is that setting?
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

theme.layout_tile                   = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps               = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft               = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom             = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop                = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv                  = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh                  = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral                 = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle                = theme.confdir .. "/icons/dwindle.png"
theme.layout_max                    = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen             = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier              = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating               = theme.confdir .. "/icons/floating.png"


return theme
