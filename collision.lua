function collide(o, area_value, area_property, dx, dy)
	dx = dx or 0
	dy = dy or 0
	-- infer bounding box from object attributes, offset by the requested move
	local x1 = (o.x + dx) / 8
	local y1 = (o.y + dy) / 8
	local x2 = (o.x + dx + o.w) / 8
	local y2 = (o.y + dy + o.h) / 8

	local function assert(x, y, area_value, area_property)
		if (area_property == 'flag') then
			return fget(mget(x, y),	area_value)
		end

		return mget(x, y) == area_value
	end

	-- check for flag 0 for tiles under each corner
	local TL = assert(x1,y1,area_value,area_property)
	local TR = assert(x2,y1,area_value,area_property)
	local BL = assert(x1,y2,area_value,area_property)
	local BR = assert(x2,y2,area_value,area_property)

	if (TL or TR or BL or BR) return true
	return false
end
