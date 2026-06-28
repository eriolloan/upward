function add_float_anim(obj)
	if not up then
		up = 1
	end

	anim = obj.anims[obj.anim]
	up = (up + flr((time() * anim.spd) % #anim.frames)) * -1
	obj.y += up
end


function spr_animated(obj)
	anim = obj.anims[obj.anim]
	-- NOTE: #array => size of the array
	frame = flr((time() * anim.spd) % #anim.frames) + 1

	if frame > #anim.frames then
		frame = 1
	end

	spr(anim.frames[frame],obj.x, obj.y, obj.w/8, obj.h/8, obj.flip)
end