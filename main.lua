function _init()
	palt(0, false)
	palt(14, true)

	pal( 10, 13+128, 1) --add dark blue
	pal( 8, 2+128, 1)
	pal( 11, 1+128, 1) --add dark blue

	init_player()
end

function _update60()
	cls(13)

	check_inputs(p)
	move(p)
end

function _draw()
	map()
	spr_animated(p)
end