function init_camera(o)
	cam = {
		x = o.x - 64 + (o.w / 2),
		y = o.y - 64 + (o.h / 2),
		offset_x = 0,
		offset_y = 0,
		will_overfow = {}
	}
end


function update_camera_future_overflows()
		local x_shift = (player.w / 2)
		local y_shift = (player.h / 2)
		local edges = {
			L=false,
			R=false,
			T=false,
			B=false,
		}

		if (mget((player.x - 64 + x_shift) / 8, 1) == 0)	edges.L=true
		if (mget((player.x + 64 + player.w) / 8, 1) == 0)	edges.R=true
		if (mget(1, (player.y - 64 + y_shift) / 8) == 0)	edges.T=true
		if (mget(1, (player.y + 55 + player.h) / 8) == 0)	edges.B=true


		-- tile_x = (cam.offset_x -1) / 8
		-- tile_y = (cam.offset_y -1) / 8
		-- tile_x2 = (cam.offset_x + 128) / 8
		-- tile_y2 = (cam.offset_y + 128) / 8

		-- if (mget(tile_x, tile_y) == 0)	edges.L=true
		-- if (mget(tile_x2, tile_y) == 0)	edges.R=true
		-- if (mget(tile_x, tile_y2) == 0)		edges.T=true
		-- if (mget(tile_x2, tile_y2) == 0)	edges.B=true


		cam.touches = edges
end


function camera_follow(o)
	local x = o.x - 63 + (o.w / 2)
	local y = o.y - 63 + (o.h / 2)
	local fallback_x = 64 + (o.w)
	local fallback_y = 128 - (o.w/2)

	update_camera_future_overflows()

	-- force camera back to the map
	if (cam.touches.L) x=0
	if (cam.touches.R) x=fallback_x
	if (cam.touches.T) y=0
	if (cam.touches.B) y=fallback_y

	cam.x, cam.y = x, y
	camera(x, y)
end