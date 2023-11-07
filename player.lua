function init_player()

	player={
		x=55,
		y=55,
		x_move_val = 3,
		y_move_val = 3,
		sp=1, -- sprite to display
		w=16,
		h=16,
		f=false, -- flip the sprite
		anim="fly", --current animation
		anims={
			fly={
				frames={1,3,5}, -- sprites for animation
				spd=2,
			}
		}
	}
end


function move_player()
	local current_x = player.x
	local current_y = player.y
	local x_move = player.x_move_val
	local y_move = player.y_move_val

	-- update player position
	-- update offsets from real (0, 0), used to reposition camera
	-- flips player sprite to reflect direction
	if (btn(⬅️)) player.x-=x_move cam.offset_x-=x_move player.f=true
	if (btn(➡️)) player.x+=x_move cam.offset_x+=x_move player.f=false
	if (btn(⬆️)) player.y-=y_move cam.offset_y-=y_move
	if (btn(⬇️)) player.y+=y_move cam.offset_y+=y_move

	-- prevent further movement when colliding
	if (collide(player, 0, 'flag')) player.x=current_x player.y=current_y

	-- update camera position
	camera_follow(player)
end