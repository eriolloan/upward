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

	check_inputs()
	if press_dir then
		p.state="move"
		move(p)
		return
	end

	p.state="idle"
end

function _draw()
	map()
	print(p.state, 8, 8, 7)

	spr_animated(p)
end