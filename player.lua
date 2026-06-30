function init_player()
	p={
		x=55,
		y=55,
		spd={
			x = 1,
			y = 1,
		},
		dir = {
			x = 0,
			y = 0,
		},
		spr=1, -- sprite to display
		w=16,
		h=16,
		flip=false, -- flip the sprite
		anims={
			idle={
				frames={1,3,5}, -- sprites for animation
				spd=2,
			},
			move={
				frames={1,3,5}, -- sprites for animation
				spd=5,
			}
		},
		col = {3, 5, 12, 5, 3, 14, 12, 14},
		state="idle",
		diag=false, -- true while moving diagonally, for phase-snap detection
	}
end

function check_inputs(obj)
	obj.dir.x=0
	obj.dir.y=0

	if btn(⬅️) then
		obj.dir.x=-1
		obj.flip=true
	end
	if btn(➡️) then
		obj.dir.x=1
		obj.flip=false
	end
	if btn(⬆️) then
		obj.dir.y=-1
	end
	if btn(⬇️) then
		obj.dir.y=1
	end
end