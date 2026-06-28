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
		state="idle",
		diag=false, -- true while moving diagonally, for phase-snap detection
	}
end


function move(obj)
	local dx = obj.dir.x * obj.spd.x
	local dy = obj.dir.y * obj.spd.y

	-- diagonal: scale this frame's step so diagonal speed ~= orthogonal.
	-- applied to the local step, never to obj.spd, so orthogonal keeps full speed.
	if obj.dir.x != 0 and obj.dir.y != 0 then
		dx *= 0.7
		dy *= 0.7
	end

	-- only advance if the destination tiles aren't flagged solid
	if (collide(obj, 0, 'flag', dx, dy)) return

	obj.x += dx
	obj.y += dy
end

function check_inputs()
	press_dir=0
	p.dir.x=0
	p.dir.y=0

	if btn(⬅️) then
		press_dir+=1
		p.dir.x = -1
		p.flip=true
	end
	if btn(➡️) then
		press_dir+=1
		p.dir.x= 1
		p.flip=false
	end
	if  btn(⬆️) then
		press_dir+=1
		p.dir.y=-1
	end
	if btn(⬇️) then
		press_dir+=1
		p.dir.y=1
	end

	-- snap to pixel when entering a diagonal so the sub-pixel cadence always
	-- starts in the same phase. invisible: the sprite is drawn floored anyway.
	local diag = p.dir.x != 0 and p.dir.y != 0
	if diag and not p.diag then
		p.x = flr(p.x)
		p.y = flr(p.y)
	end
	p.diag = diag
end