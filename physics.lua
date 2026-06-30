function collide(o, area_value, area_property, dx, dy)
	dx = dx or 0
	dy = dy or 0

	local function assert(x, y, area_value, area_property)
		if (area_property == 'flag') then
			return fget(mget(x, y),	area_value)
		end

		return mget(x, y) == area_value
	end

	-- test the tile under each collision point, offset by the requested move
	for i=1,#o.col,2 do
		local x = (o.x + dx + o.col[i]) / 8
		local y = (o.y + dy + o.col[i+1]) / 8
		if (assert(x, y, area_value, area_property)) return true
	end

	return false
end

-- would moving obj by (dx,dy) land any collision point on a solid tile?
function solid(obj, dx, dy)
	return collide(obj, 0, 'flag', dx, dy)
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
	if solid(obj, dx, dy) then
		if obj.diag then
			-- diagonal slide: drop the component whose own axis is solid
			local hit_h = solid(obj, dx, 0)
			local hit_v = solid(obj, 0, dy)
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
					if not solid(obj, dx+ox, dy+oy) then
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
