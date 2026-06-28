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
