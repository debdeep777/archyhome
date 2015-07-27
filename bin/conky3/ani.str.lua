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

min_rad=150
comm_thickness=10
min_gap=2
rad_incr=min_gap+comm_thickness

rad_cpus=min_rad+rad_incr


require 'cairo'

local cs,display
local main_start=0
local degree2radian=0
local percent2radian=0
local one_sixth_of_circle=0
local one_eighth_of_circle=0
local global_oscillator=0

three_arc_speed=0.003		-- relatively smaller number than the ring_speed because it's a bigger circle. So small rotation is visible
--ring_speed=-0.02		-- CCW hence negative
ring_speed=-0.002	-- CCW hence negative
value_update_cycle=50		-- After these many increments of the global_oscillation variable, the values get updated

function oscillation_template()
	local counter=0
	return
		function (increament)
			counter=counter+increament
			return counter
		end
end

function col_conv(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

local app_data =
		{	
			['systemavg']={	name='SystemAvg', name_update_code='no update',
							cpu=0, cpu_update_code='${cpu cpu0}',
							mem=0, mem_update_code='${memperc}',
fg_col=sol_violet,bg_col=sol_base01,
							x=clock_x, y=clock_y, r=min_rad, oscillator=oscillation_template() },

-- Theses 4 are in the same axis, with radius = rad_cpus

			['cpus']={	name='AllCPUs', name_update_code='no update',
								cpu0=0,cpu1=0,cpu2=0,cpu3=0,
								cpu0_code='${cpu cpu0}',
								cpu1_code='${cpu cpu1}',
								cpu2_code='${cpu cpu2}',
								cpu3_code='${cpu cpu3}', 
fg_col=sol_green,bg_col=sol_base01, -- This color is not used in the main function for this element
							x=clock_x, y=clock_y, r=rad_cpus, oscillator=oscillation_template() },



			['top1m']={		name='Top1M', name_update_code='${top_mem name 1}',
							cpu=0, cpu_update_code='${top_mem cpu 1}',
							mem=0, mem_update_code='${top_mem mem 1}',
fg_col=sol_green,bg_col=sol_base01,
							x=clock_x, y=clock_y, r=min_rad+2*rad_incr, oscillator=oscillation_template() },
			['top1']={		name='Top1', name_update_code='${top name 1}',
							cpu=0, cpu_update_code='${top cpu 1}',
							mem=0, mem_update_code='${top mem 1}',
fg_col=sol_cyan,bg_col=sol_base01,
							x=clock_x, y=clock_y, r=min_rad+3*rad_incr, oscillator=oscillation_template() }

--			['top2']={		name='Top2', name_update_code='${top name 2}',
--							cpu=0, cpu_update_code='${top cpu 2}',
--							mem=0, mem_update_code='${top mem 2}',
--fg_col=sol_cyan,bg_col=sol_base01,
--							x=clock_x, y=clock_y, r=min_rad+4*rad_incr, oscillator=oscillation_template() }
		}

function conky_init()
	main_start=0
	degree2radian=math.pi/180
	percent2radian=math.pi/50
	one_sixth_of_circle=math.pi/3
	one_eighth_of_circle=math.pi/4

	-- cancel runtime tonumber bug
	for i,v in pairs(app_data) do
	   if v.name~='AllCPUs' then
		if v.name_update_code~='no update' then conky_parse(v.name_update_code) end
		tonumber(conky_parse(v.cpu_update_code))
		tonumber(conky_parse(v.mem_update_code))
	   else
	   	tonumber(conky_parse(v.cpu0_code))
		tonumber(conky_parse(v.cpu1_code))
		tonumber(conky_parse(v.cpu2_code))
		tonumber(conky_parse(v.cpu3_code))
	   end
	end

end

function show_text(x,y,content)
	cairo_move_to(display,x,y)
	cairo_show_text(display,content)
	cairo_stroke (display)
end


function draw_sring(v,x,y,r,tilted_angle,angular_width)
	if angular_width < 0.1 then angular_width=0.1 end
	local thickness=comm_thickness

	local begin_angle,end_angle=tilted_angle-angular_width/2,tilted_angle+angular_width/2


	cairo_set_line_width (display,thickness)

-- the arc
	cairo_set_source_rgba (display, col_conv(v.fg_col,0.4))
	cairo_arc (display, x, y, r, begin_angle, end_angle)
	cairo_stroke (display)

-- background ring, not really in the background, just the rest of the ring
	cairo_set_source_rgba (display,col_conv(v.bg_col,0.4))
	cairo_arc (display, x, y, r, end_angle, begin_angle)
	cairo_stroke (display)

end

function draw_rotating_4_cpu_block(v,x,y,r,tilted_angle,val0,val1,val2,val3)

	local thickness=comm_thickness

--Overriding nice settings
	r = 300
	thickness = 50



-- 	local thick0 =  0.5*thickness*math.sin(tilted_angle/4)+ (0.5*thickness)*val0*0.01
--	local thick1 =  0.5*thickness*math.sin(tilted_angle/4)+ (0.5*thickness)*val1*0.01
--	local thick2 =  0.5*thickness*math.sin(tilted_angle/4)+ (0.5*thickness)*val2*0.01
--	local thick3 =  0.5*thickness*math.sin(tilted_angle/4)+ (0.5*thickness)*val3*0.01

 	local thick0 =  5*(0.5*thickness)*val0*0.01
	local thick1 =  5*(0.5*thickness)*val1*0.01
	local thick2 =  5*(0.5*thickness)*val2*0.01
	local thick3 =  5*(0.5*thickness)*val3*0.01

	local r0 = r - 0.5*(thickness - thick0)
	local r1 = r - 0.5*(thickness - thick1)
	local r2 = r - 0.5*(thickness - thick2)
	local r3 = r - 0.5*(thickness - thick3)

local buf=one_eighth_of_circle/2.1


	fg_r,fg_g,fg_b,fg_a=col_conv(v.fg_col, 0.4)
-- What kind of color change is this?? Only Blue and Alpha
	--cairo_set_source_rgba (display, 0.2, 0.8, 0.4+0.4*math.sin(0.5*tilted_angle), 0.4-0.14*math.sin(tilted_angle))
	--cairo_set_source_rgba (display, 0.2, 0.8, 0.4+0.4*math.sin(0.5*tilted_angle), 0.4)
	--
	cairo_set_source_rgba (display, fg_r,fg_g, fg_b+fg_b*math.sin(0.5*tilted_angle), fg_a)

	cairo_set_line_width (display,thick0)
	cairo_arc (display, x, y, r0, tilted_angle-buf, tilted_angle+one_eighth_of_circle+buf)
	cairo_stroke (display)

	tilted_angle=tilted_angle+2*one_eighth_of_circle
	cairo_set_line_width (display,thick1)
	cairo_arc (display, x, y, r1, tilted_angle-buf, tilted_angle+one_eighth_of_circle+buf)
	cairo_stroke (display)
	
	tilted_angle=tilted_angle+2*one_eighth_of_circle
	cairo_set_line_width (display,thick2)
	cairo_arc (display, x, y, r2, tilted_angle-buf, tilted_angle+one_eighth_of_circle+buf)
	cairo_stroke (display)

	tilted_angle=tilted_angle+2*one_eighth_of_circle
	cairo_set_line_width (display,thick3)
	cairo_arc (display, x, y, r3, tilted_angle-buf, tilted_angle+one_eighth_of_circle+buf)
	cairo_stroke (display)

end

function show_app_data(j,v)
	local x,y,r=v.x,v.y,v.r

if j%2 == 0 then sgn=1 else sgn = (-1) end
-- What is this tilted angle? 0.003*v.oscillator(v.cpu+1)
-- It does not follow global_oscillation (which is uniform rotation)
-- Instead, tilted angle is incremented directly related to v.cpu
-- For a fixed v.cpu (wen the value is not updated), the sequence is: three_arc_speed * (v.cpu+1) * i , where i = 1, 2, 3, ...
-- end end
	--draw_rotating_3_arc_block(x, y, r, three_arc_speed*v.oscillator(v.cpu+1))
	--draw_sring(x,y,r*0.58,ring_speed*global_oscillator,v.mem*percent2radian)
	draw_sring(v,x,y,r,sgn*ring_speed*v.oscillator(v.cpu+1),v.mem*percent2radian)
	--show_text(x-20,y,v.name)
	show_text(x-20,y+r,v.name)
end


function show_cpu_data(j,v)
	local x,y,r=v.x,v.y,v.r
if j%2 == 0 then sgn=1 else sgn = (-1) end

	draw_rotating_4_cpu_block(v,x, y, r, sgn*ring_speed*global_oscillator, v.cpu0,v.cpu1,v.cpu2,v.cpu3)
	--show_text(x-20,y,v.name)
	show_text(x-20,y+r,v.name)
end

function conky_main()

	if main_start==1 then
		global_oscillator=global_oscillator+1

		local j=0
		for i,v in pairs(app_data) do
			
			if global_oscillator % value_update_cycle == 0 then -- update data in longer intervals
				
				   if v.name ~='AllCPUs' then 

					if v.name_update_code ~= 'no update' then v.name=conky_parse(v.name_update_code) end
					v.cpu=tonumber(conky_parse(v.cpu_update_code))
					v.mem=tonumber(conky_parse(v.mem_update_code))
				   else
					   v.cpu0=tonumber(conky_parse(v.cpu0_code))
					   v.cpu1=tonumber(conky_parse(v.cpu1_code))
					   v.cpu2=tonumber(conky_parse(v.cpu2_code))
					   v.cpu3=tonumber(conky_parse(v.cpu3_code))

					   

				   end
			end
			j=j+1
			
			if v.name =='AllCPUs' then 
					show_cpu_data(j,v)
			else
				show_app_data(j,v)
			end
			
			
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

