function init_slates()
	slates = {
		{0},
		{136, 134, 132, 0},
		{0, 134, 132, 0},
		{0},
	}
end

function draw_slates(x,y)
	--draw slots background
	rectfill(osd_x+osd.m, osd_y+osd.m, osd_x-2*osd.m-1+osd_w, osd_x-2*osd.m-1+osd_y, 6)

	for r, row in ipairs(slates) do

		local c=max_cols(slates)

		-- draw slots
		while c>=0 do
			local sp=128
			if (c==max_cols(slates)) sp=130 -- future slot sprite
			s_x=x+c*14
			s_y=y+(r-1)*14

			-- slot background (square outline)
			spr(sp, s_x-1, s_y-1, 2,2)

			-- draw limits outline
			local w=2
			if (c==max_cols(slates)) w=1 -- draw half the limit for future slots

			-- water limit (line 2)
			if r==2 then
				for s, slate in ipairs(slates[r]) do
					spr(162, s_x-1, s_y+1, w,1)
				end
			end
			c-=1
		end

		-- slates
		for s, slate in ipairs(slates[r]) do
			slt_x=osd_x+osd.m+(s-1)*14
			slt_y=osd_y+osd.m+(r-1)*14

			-- draw limit backgrounds when there is a slate
			if (r==2 and slate!=0) spr(176, slt_x-1, slt_y+7, 2,1)

			--draw_slate
			if (slate!=0) spr(slate, slt_x-1, slt_y-1, 2,2)
		end
	end
end
