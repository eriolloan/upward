osd = {
	visible=false,
	w=0,
	h=0,
	m=4, -- margin around slots
}


function draw_osd()

	-- size osd according to contained slates
	osd_w=osd.m+16*max_cols(slates)
	osd_h=osd.m+16*#slates
	osd_x=(120-osd_w)/2-osd.m
	osd_y=128-osd_h-8

	-- osd background
	rectfill(osd_x, osd_y, osd_x+osd_w+8, osd_y+osd_h+8, 7)

	draw_slates(osd_x+4,osd_y+4)
end

function toggle_osd()
	-- change `btnp` input delay to report only one input
	poke(0X5F5C, 255)
	-- using `btnp` instead of `btn` as `btn` reports one intput per frame
	if (btnp(❎)) osd.visible = not osd.visible
	if (osd.visible) draw_osd()
end