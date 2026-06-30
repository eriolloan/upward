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

	-- destination blocked: honor the move on whichever axis is still free
	if collide(obj, 0, 'flag', dx, dy) then
		if obj.diag then
			-- diagonal slide: drop the component whose own axis is solid
			local hit_h = collide(obj, 0, 'flag', dx, 0)
			local hit_v = collide(obj, 0, 'flag', 0, dy)
			if (hit_h) dx = 0
			if (hit_v) dy = 0
			-- pure corner (only the diagonal tile is solid): don't cut it
			if (not hit_h and not hit_v) return
		else
			-- orthogonal block: corner slip — nudge perpendicular to round a corner.
			-- perpendicular axis = the one we're NOT moving along.
			local px = (dx == 0) and 1 or 0
			local py = (dy == 0) and 1 or 0

			-- search outward for the nearest free offset on either side
			for k=1,4 do
				for s=-1,1,2 do
					local ox = px*s*k
					local oy = py*s*k
					if not collide(obj, 0, 'flag', dx+ox, dy+oy) then
						-- keep advancing, plus the perpendicular nudge
						obj.x += dx+ox
						obj.y += dy+oy
						return
					end
				end
			end

			return -- no slip room: hold position
		end
	end

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