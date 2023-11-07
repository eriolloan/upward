-- to get TOKENS/CHARS COUNT use the `info` command in pic-8

function _init()
	-- clear old logs
	log("", true)

	palt(14, true) -- pink is transparent
	palt(0, false) -- black is opaque

	init_player()
	init_camera(player)
	init_slates()
end


function _update()
	-- player movement
	move_player()
	toggle_osd()
end

function _draw()
	-- background color
	cls(13)
	pal( 10, 13+128, 1) --add dark blue
	pal( 8, 2+128, 1)
	pal( 11, 1+128, 1) --add dark blue

	smap(0,0,16,16,0,0,128,128)
	smap(16,0,32,16,128,0,256,128,false,true)

	-- add_float_anim(player)
  spr_animated(player)
	camera(0, 0)
	if (osd.visible) draw_osd()
end
