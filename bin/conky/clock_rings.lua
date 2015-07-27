--[[
Clock Rings by londonali1010 (2009)

This script draws percentage meters as rings, and also draws clock hands if you want! It is fully customisable; all options are described in the script. This script is based off a combination of my clock.lua script and my rings.lua script.

IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault if it tries to draw a ring straight away. The if statement near the end of the script uses a delay to make sure that this doesn't happen. It calculates the length of the delay by the number of updates since Conky started. Generally, a value of 5s is long enough, so if you update Conky every 1s, use update_num > 5 in that if statement (the default). If you only update Conky every 2s, you should change it to update_num > 3; conversely if you update Conky every 0.5s, you should use update_num > 10. ALSO, if you change your Conky, is it best to use "killall conky; conky" to update it, otherwise the update_num will not be reset and you will get an error.

To call this script in Conky, use the following (assuming that you save this script to ~/scripts/rings.lua):
	lua_load ~/scripts/clock_rings-v1.1.1.lua
	lua_draw_hook_pre clock_rings

Changelog:
+ v1.1.1 -- Fixed minor bug that caused the script to crash if conky_parse() returns a nil value (20.10.2009)
+ v1.1 -- Added colour option for clock hands (07.10.2009)
+ v1.0 -- Original release (30.09.2009)
]]


-- Solarized colors
sol_base3   =0x1c1c1c
sol_base2   =0x262626
sol_base1   =0x585858
sol_base0   =0x626262
sol_base00  =0x808080
sol_base01  =0x8a8a8a
sol_base02  =0xe4e4e4
sol_base03  =0xffffd7
sol_yellow  =0xaf8700
sol_orange  =0xd75f00
sol_red     =0xd70000
sol_magenta =0xaf005f
sol_violet  =0x5f5faf
sol_blue    =0x0087ff
sol_cyan    =0x00afaf
sol_green   =0x5f8700


-- Centre of the big circle
-- "clock_x" and "clock_y" are the coordinates of the centre of the clock, in pixels, from the top left of the Conky window.

clock_x=683
clock_y=384

dot_rad=330;

-- For the first three rings
clock_min_rad=240
min_incr=10
min_gap=4
min_thk=(min_incr-min_gap)


clock_r=clock_min_rad+(min_incr*2)+50

--For the next set of rings
inf_rad = 105
inf_incr= 10


hr_col=sol_green
min_col=sol_cyan
sec_col=sol_orange


settings_table = {

	-- Modified second's ring cum border
	{
		name='time',
		arg='%S',
		max=60,
		bg_colour=0xffffff,
		bg_alpha=0.1,
		fg_colour=0xffffff,
		fg_alpha=0.4,
		x=clock_x, y=clock_y,
		radius=dot_rad;
		thickness=1,
		start_angle=0,
		end_angle=360
	},
	{
		-- Edit this table to customise your rings.
		-- You can create more rings simply by adding more elements to settings_table.
		-- "name" is the type of stat to display; you can choose from 'cpu', 'memperc', 'fs_used_perc', 'battery_used_perc'.
		name='time',
		-- "arg" is the argument to the stat type, e.g. if in Conky you would write ${cpu cpu0}, 'cpu0' would be the argument. If you would not use an argument in the Conky variable, use ''.
		arg='%I.%M',
		-- "max" is the maximum value of the ring. If the Conky variable outputs a percentage, use 100.
		max=12,
		-- "bg_colour" is the colour of the base ring.
		bg_colour=0xffffff,
		-- "bg_alpha" is the alpha value of the base ring.
		bg_alpha=0.1,
		-- "fg_colour" is the colour of the indicator part of the ring.
		fg_colour=hr_col,
		-- "fg_alpha" is the alpha value of the indicator part of the ring.
		fg_alpha=0.4,
		-- "x" and "y" are the x and y coordinates of the centre of the ring, relative to the top left corner of the Conky window.
		x=clock_x, y=clock_y,
		-- "radius" is the radius of the ring.
		radius=clock_min_rad,
		-- "thickness" is the thickness of the ring, centred around the radius.
		thickness=min_thk,
		-- "start_angle" is the starting angle of the ring, in degrees, clockwise from top. Value can be either positive or negative.
		start_angle=0,
		-- "end_angle" is the ending angle of the ring, in degrees, clockwise from top. Value can be either positive or negative, but must be larger than start_angle.
		end_angle=360
	},
	{
		name='time',
		arg='%M.%S',
		max=60,
		bg_colour=0xffffff,
		bg_alpha=0.1,
		fg_colour=min_col,
		fg_alpha=0.4,
		x=clock_x, y=clock_y,
		radius=clock_min_rad+min_incr*1.5,
		thickness=min_thk*3,
		start_angle=0,
		end_angle=360
	},
	{
		name='time',
		arg='%S',
		max=60,
		bg_colour=0xffffff,
		bg_alpha=0.1,
		fg_colour=sec_col,
		fg_alpha=0.4,
		x=clock_x, y=clock_y,
		radius=clock_min_rad+(3*min_incr),
		thickness=min_thk,
		start_angle=0,
		end_angle=360
	},
--	{
--		name='cpu',
--		arg='cpu4',
--		max=100,
--		bg_colour=0xffffff,
--		bg_alpha=0.2,
--		fg_colour=0xffffff,
--		fg_alpha=0.5,
--		x=clock_x, y=clock_y,
--		radius=75,
--		thickness=5,
--		start_angle=93,
--		end_angle=208
--	},
--	{
--		name='cpu',
--		arg='cpu1',
--		max=100,
--		bg_colour=0xffffff,
--		bg_alpha=0.2,
--		fg_colour=0xffffff,
--		fg_alpha=0.5,
--		x=clock_x, y=clock_y,
--		radius=81,
--		thickness=5,
--		start_angle=93,
--		end_angle=208
--	}, 
--	{
--		name='cpu',
--		arg='cpu2',
--		max=100,
--		bg_colour=0xffffff,
--		bg_alpha=0.2,
--		fg_colour=0xffffff,
--		fg_alpha=0.5,
--		x=clock_x, y=clock_y,
--		radius=87,
--		thickness=5,
--		start_angle=93,
--		end_angle=208
--	},
--	{
--		name='cpu',
--		arg='cpu3',
--		max=100,
--		bg_colour=0xffffff,
--		bg_alpha=0.2,
--		fg_colour=0xffffff,
--		fg_alpha=0.5,
--		x=clock_x, y=clock_y,
--		radius=93,
--		thickness=5,
--		start_angle=93,
--		end_angle=208
--	},
	{
		name='memperc',
		arg='',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=sol_magenta,
		fg_alpha=0.5,
		x=clock_x, y=clock_y,
		radius=84,
		thickness=23,
		start_angle=212,
		end_angle=329
	},
	{
		name='battery_percent',
		arg='BAT1',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=sol_blue,
		fg_alpha=0.5,
		x=clock_x, y=clock_y,
		radius=84,
		thickness=23,
		start_angle=-27,
		end_angle=85
	},
--	{
--		name='',
--		arg='',
--		max=1,
--		bg_colour=0xd5dcde,
--		bg_alpha=1,
--		fg_colour=0xd5dcde,
--		fg_alpha=1,
--		x=clock_x, y=clock_y,
--		radius=120,
--		thickness=2,
--		start_angle=75,
--		end_angle=105
--	},
--	{
--		name='',
--		arg='',
--		max=1,
--		bg_colour=0xd5dcde,
--		bg_alpha=1,
--		fg_colour=0xd5dcde,
--		fg_alpha=1,
--		x=clock_x, y=clock_y,
--		radius=125,
--		thickness=2,
--		start_angle=73,
--		end_angle=108
--	},
--	{
--		name='',
--		arg='',
--		max=1,
--		bg_colour=0xd5dcde,
--		bg_alpha=1,
--		fg_colour=0xd5dcde,
--		fg_alpha=1,
--		x=clock_x, y=clock_y,
--		radius=130,
--		thickness=2,
--		start_angle=71,
--		end_angle=111
--	},
--	{
--		name='',
--		arg='',
--		max=1,
--		bg_colour=0xffffff,
--		bg_alpha=1,
--		fg_colour=0xffffff,
--		fg_alpha=1,
--		x=clock_x, y=clock_y,
--		radius=403,
--		thickness=2,
--		start_angle=86,
--		end_angle=94
--	}, 



--[[
	{
		name='time',
		arg='%m',
		max=12,
		bg_colour=0xffffff,
		bg_alpha=0.1,
		fg_colour=0xffffff,
		fg_alpha=0.8,
		x=840, y=170,
		radius=76,
		thickness=5,
		start_angle=212,
		end_angle=360
	}, ]]
	{
		name='fs_used_perc',
		arg='/',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=sol_yellow,
		fg_alpha=0.5,
		x=clock_x, y=clock_y,
		radius=105,
		thickness=9,
		start_angle=-120,
		end_angle=-13
	},
	{
		name='fs_used_perc',
		arg='/storage',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=sol_cyan,
		fg_alpha=0.5,
		x=clock_x, y=clock_y,
		radius=105,
		thickness=9,
		start_angle=-10,
		end_angle=120
	},
}

-- Use these settings to define the origin and extent of your clock.



-- Colour & alpha of the clock hands

clock_colour=0xffffff
clock_alpha=0.5

-- Do you want to show the seconds hand?

show_seconds=true

require 'cairo'

function rgb_to_r_g_b(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
	local w,h=conky_window.width,conky_window.height

	local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
	local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

	local angle_0=sa*(2*math.pi/360)-math.pi/2
	local angle_f=ea*(2*math.pi/360)-math.pi/2
	local t_arc=t*(angle_f-angle_0)

	-- Draw background ring

	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,ring_w)
	cairo_stroke(cr)

	-- Draw indicator ring

	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	cairo_stroke(cr)
end

function draw_clock_hands(cr,xc,yc)
	local secs,mins,hours,secs_arc,mins_arc,hours_arc
	local xh,yh,xm,ym,xs,ys

	secs=os.date("%S")
	mins=os.date("%M")
	hours=os.date("%I")

	secs_arc=(2*math.pi/60)*secs
	mins_arc=(2*math.pi/60)*mins+secs_arc/60
	hours_arc=(2*math.pi/12)*hours+mins_arc/12

-- The drawing of the markers

--	 Static clock border
	
	cairo_set_source_rgba(cr,rgb_to_r_g_b(clock_colour,clock_alpha))

	cairo_set_line_width(cr,1)
	cairo_arc(cr,clock_x,clock_y,dot_rad,0,2*math.pi)
	cairo_stroke(cr);

-- Fun markers
--    test_len=dot_rad
--	k=0
--	while k < 12 do
--		if k%2 == 0 then
--			cairo_arc(cr,clock_x,clock_y,test_len,k*math.pi/6,(k+1)*math.pi/6)
--		end
--		k = k+1
--		cairo_stroke (cr);
--	end




i=0
while i <360 do


	if i%90 == 0 then
		loc_len=-20;
		cairo_set_line_width(cr,9)

	elseif i%30 == 0 then
		loc_len=-20;
		cairo_set_line_width(cr,3)
	else
		loc_len=-05;
		cairo_set_line_width(cr,1)
	end
	j = i*2*math.pi/360; --converting i degree to radian
	tot_rad=dot_rad+loc_len;
	start_x=dot_rad*math.cos(j)+clock_x;
	start_y=dot_rad*math.sin(j)+clock_y;
	  end_y=tot_rad*math.sin(j)+clock_y;
	  end_x=tot_rad*math.cos(j)+clock_x;
	cairo_move_to (cr, start_x, start_y);
	cairo_line_to (cr, end_x, end_y);


	--- Failed attempt to align texts
	---txt_dist = -10
	---if i%30 == 0 then
	---  nd_y=(tot_rad+txt_dist)*math.sin(j)+clock_y;
	---  nd_x=(tot_rad+txt_dist)*math.cos(j)+clock_x;

	---	cairo_move_to (cr, nd_x, nd_y);
	---	cairo_set_font_size (cr, 34);
	---	cairo_show_text(cr, (i/30+2)%12+1)
	---end

	cairo_set_source_rgba(cr,rgb_to_r_g_b(clock_colour,clock_alpha))


	--i=i+30;
	i=i+6;


	cairo_stroke (cr);
end




	-- Draw hour hand

	xh=xc+0.7*clock_r*math.sin(hours_arc)
	yh=yc-0.7*clock_r*math.cos(hours_arc)
	cairo_move_to(cr,xc,yc)
	cairo_line_to(cr,xh,yh)

	cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)
	cairo_set_line_width(cr,20)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(clock_colour,clock_alpha))
	cairo_stroke(cr)

	-- Draw minute hand

	xm=xc+clock_r*math.sin(mins_arc)
	ym=yc-clock_r*math.cos(mins_arc)
	cairo_move_to(cr,xc,yc)
	cairo_line_to(cr,xm,ym)

	cairo_set_line_width(cr,15)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(clock_colour,clock_alpha))
	cairo_stroke(cr)

	-- Draw seconds hand

	if show_seconds then
		xs=xc+clock_r*math.sin(secs_arc)
		ys=yc-clock_r*math.cos(secs_arc)
		cairo_move_to(cr,xc,yc)
		cairo_line_to(cr,xs,ys)

		cairo_set_line_width(cr,1)
		cairo_set_source_rgba(cr,rgb_to_r_g_b(clock_colour,clock_alpha))
		cairo_stroke(cr)
	end
end

function conky_clock_rings()
	local function setup_rings(cr,pt)
		local str=''
		local value=0

		str=string.format('${%s %s}',pt['name'],pt['arg'])
		str=conky_parse(str)

		value=tonumber(str)
		if value == nil then value = 0 end
		pct=value/pt['max']

		draw_ring(cr,pct,pt)
	end

	-- Check that Conky has been running for at least 5s

	if conky_window==nil then return end
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)

	local cr=cairo_create(cs)	

	local updates=conky_parse('${updates}')
	update_num=tonumber(updates)

--[[	Responsible for all system-related funky info that nobody cares about, except for little boys
--
	if update_num>5 then
		for i in pairs(settings_table) do
			setup_rings(cr,settings_table[i])
		end
	end
]]

--	-- Only taking the second's ring, modified. Kept it in the beginning, so i=1
--	setup_rings(cr,settings_table[1])
	
	draw_clock_hands(cr,clock_x,clock_y)
end
