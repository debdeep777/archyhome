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

-- CPU group
cpu_min_rad=150
cpu_thickness=3
cpu_gap=2
cpu_rad_incr=cpu_gap+cpu_thickness

cpu_col_fg=sol_green
cpu_col_bg=sol_base01
cpu_col_alpha=0.4

-- CPU_AVG ring
cpu_avg_thickness=20
cpu_avg_rad=cpu_min_rad+4*(cpu_thickness+cpu_gap)+cpu_avg_thickness/2
cpu_avg_col_fg=sol_yellow

-- MEM ring
mem_thickness= 30
mem_rad=cpu_avg_rad+cpu_avg_thickness+cpu_gap+mem_thickness/2
mem_col_fg=sol_green



require 'cairo'

local cs,display
local main_start=0
local degree2radian=0
local percent2radian=0
local one_sixth_of_circle=0
local one_eighth_of_circle=0
local global_oscillator=0

ring_speed=-0.002	-- CCW hence negative
value_update_cycle=50		-- After these many increments of the global_oscillation variable, the values get updated


function col_conv(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function oscillation_template()
	local counter=0
	return
		function (increament)
			counter=counter+increament
			return counter
		end
end

local cpu_data =
		{	
			['cpu1']={name='CPU-1', cpu=0, cpu_update_code='${cpu cpu1}', x=clock_x, y=clock_y, r=cpu_min_rad, oscillator=oscillation_template() },
			['cpu2']={name='CPU-2', cpu=0, cpu_update_code='${cpu cpu2}', x=clock_x, y=clock_y, r=cpu_min_rad+1*cpu_rad_incr, oscillator=oscillation_template() },
			['cpu3']={name='CPU-3', cpu=0, cpu_update_code='${cpu cpu3}', x=clock_x, y=clock_y, r=cpu_min_rad+2*cpu_rad_incr, oscillator=oscillation_template() },
			['cpu4']={name='CPU-4', cpu=0, cpu_update_code='${cpu cpu4}', x=clock_x, y=clock_y, r=cpu_min_rad+3*cpu_rad_incr, oscillator=oscillation_template() },
			['cpu0']={name='CPU-Avg', cpu=0, cpu_update_code='${cpu cpu0}', x=clock_x, y=clock_y, r=cpu_avg_rad, oscillator=oscillation_template() },
			['Mem']={name='Memperc', cpu=0, cpu_update_code='${memperc}', x=clock_x, y=clock_y, r=mem_rad, oscillator=oscillation_template() }

		}

function conky_init()
	main_start=0
	degree2radian=math.pi/180
	percent2radian=math.pi/50

	-- cancel runtime tonumber bug
	for i,v in pairs(cpu_data) do
		tonumber(conky_parse(v.cpu_update_code))
	end
end

function show_text(x,y,content)
	cairo_move_to(display,x,y)
	cairo_show_text(display,content)
	cairo_stroke (display)
end

function draw_memring(x,y,r,tilted_angle,angular_width)
	if angular_width < 0.1 then angular_width=0.1 end
	local thickness=mem_thickness

	thickness = thickness*math.sin(angular_width/2) 	-- 0 --> 0 ; ang_wid=2pi --> thickness = thickness'.
	r = r - (mem_thickness - thickness)*0.5

	local begin_angle,end_angle=tilted_angle-angular_width/2,tilted_angle+angular_width/2
	cairo_set_line_width (display,thickness)

-- the arc
	cairo_set_source_rgba (display, col_conv(mem_col_fg,cpu_col_alpha))
	cairo_arc (display, x, y, r, begin_angle, end_angle)
	cairo_stroke (display)

-- background ring, not really in the background, just the rest of the ring
	cairo_set_source_rgba (display, col_conv(cpu_col_bg,cpu_col_alpha))
	cairo_arc (display, x, y, r, end_angle, begin_angle)
	cairo_stroke (display)
end
function draw_cpu_avg_ring(x,y,r,tilted_angle,angular_width)
	if angular_width < 0.1 then angular_width=0.1 end
	local thickness=cpu_avg_thickness


	--thickness = thickness*math.sin(angular_width/2) 	-- 0 --> 0 ; ang_wid=2pi --> thickness = thickness'.

	temw= (angular_width/(2*math.pi)) - 1			-- Used Gaussian function translated to (1,0) instead of sin, so it's never zero better increment
	tempe=(-1)*temw*temw
	thickness = thickness*math.exp(tempe)

	r = r - (cpu_avg_thickness - thickness)*(1/2)

	local begin_angle,end_angle=tilted_angle-angular_width/2,tilted_angle+angular_width/2
	cairo_set_line_width (display,thickness)

-- the arc
	cairo_set_source_rgba (display, col_conv(cpu_avg_col_fg,cpu_col_alpha))
	cairo_arc (display, x, y, r, begin_angle, end_angle)
	cairo_stroke (display)

-- background ring, not really in the background, just the rest of the ring
	cairo_set_source_rgba (display, col_conv(cpu_col_bg,cpu_col_alpha))
	cairo_arc (display, x, y, r, end_angle, begin_angle)
	cairo_stroke (display)
end
function draw_cpuring(x,y,r,tilted_angle,angular_width)
	if angular_width < 0.1 then angular_width=0.1 end

	local thickness=cpu_thickness

	local begin_angle,end_angle=tilted_angle-angular_width/2,tilted_angle+angular_width/2
	cairo_set_line_width (display,thickness)

-- the arc
	cairo_set_source_rgba (display, col_conv(cpu_col_fg,cpu_col_alpha))
	cairo_arc (display, x, y, r, begin_angle, end_angle)
	cairo_stroke (display)

-- background ring, not really in the background, just the rest of the ring
	cairo_set_source_rgba (display, col_conv(cpu_col_bg,cpu_col_alpha))
	cairo_arc (display, x, y, r, end_angle, begin_angle)
	cairo_stroke (display)
end



function show_cpu_data(j,v)
	local x,y,r=v.x,v.y,v.r
	if j%2 == 0 then sgn = 1 else sgn = (-1) end

	if v.name == 'CPU-Avg' then
		draw_cpu_avg_ring(x,y,r,sgn*ring_speed*global_oscillator,v.cpu*percent2radian)
	elseif v.name == 'Memperc' then
		draw_memring(x,y,r,sgn*ring_speed*global_oscillator,v.cpu*percent2radian)
	else
		draw_cpuring(x,y,r,sgn*ring_speed*v.oscillator(v.cpu+1),v.cpu*percent2radian)
	end

	--show_text(x-20,y,v.name)
	show_text(x-20,y+r,v.name)
end


function conky_main()

	if main_start==1 then
		global_oscillator=global_oscillator+1
		
		local j=0
		for i,v in pairs(cpu_data) do
			if global_oscillator % value_update_cycle == 0 then -- update data in longer intervals
				v.cpu=tonumber(conky_parse(v.cpu_update_code))
			end
			show_cpu_data(j,v)
			j=j+1
		end
	else
		if tonumber(conky_parse('${updates}')) > 5 then
			main_start=1
			cs=cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
			display=cairo_create(cs)
		end
	end
end

function conky_end()
	cairo_destroy(display)
	cairo_surface_destroy(cs)
end

