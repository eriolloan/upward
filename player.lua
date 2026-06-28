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
		col = {6, 5, 9, 5, 2, 14, 13, 14},
		state="idle",
		diag=false, -- true while moving diagonally, for phase-snap detection
	}
end


function move(obj)
	local diag = obj.dir.x != 0 and obj.dir.y != 0

	-- no direction: idle, and reset phase so the next diagonal starts clean
	if obj.dir.x == 0 and obj.dir.y == 0 then
		obj.state = "idle"
		obj.diag = false
		return
	end

	-- entering a diagonal: snap to pixel so the sub-pixel cadence starts in
	-- phase. invisible -- the sprite is drawn floored anyway.
	if diag and not obj.diag then
		obj.x = flr(obj.x)
		obj.y = flr(obj.y)
	end
	obj.diag = diag

	local dx = obj.dir.x * obj.spd.x
	local dy = obj.dir.y * obj.spd.y

	-- scale the diagonal step so diagonal speed ~= orthogonal.
	-- applied to the local step, never to obj.spd, so orthogonal keeps full speed.
	if diag then
		dx *= 0.7
		dy *= 0.7
	end

	obj.state = "move"

	-- only advance if the destination tiles aren't flagged solid
	if (collide(obj, 0, 'flag', dx, dy)) return

	obj.x += dx
	obj.y += dy
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