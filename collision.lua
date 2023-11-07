function collide(o, area_value, area_property)
	-- infer bounding box from object attributes
	local x1 = o.x / 8
	local y1 = o.y / 8
	local x2 = (o.x + o.w) / 8
	local y2 = (o.y + o.h) / 8

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
