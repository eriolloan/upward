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
	}
end


function move(obj)
	local dx = obj.dir.x * obj.spd.x
	local dy = obj.dir.y * obj.spd.y

	-- only advance if the destination tiles aren't flagged solid
	if (collide(obj, 0, 'flag', dx, dy)) return

	obj.x += dx
	obj.y += dy
end

function check_inputs()
	press_dir=false
	p.dir.x=0
	p.dir.y=0

	if btn(⬅️) then
		press_dir=true
		p.dir.x = -1
		p.flip=true
	elseif btn(➡️) then
		press_dir=true
		p.dir.x= 1
		p.flip=false
	elseif  btn(⬆️) then
		press_dir=true
		p.dir.y=-1
	elseif btn(⬇️) then
		press_dir=true
		p.dir.y=1
	end
end