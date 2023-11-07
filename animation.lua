function add_float_anim(object)
	if not up then
		up = 1
	end
	anim = object.anims[object.anim]
	up = (up + flr((time() * anim.spd) % #anim.frames)) * -1
	object.y += up
end


function spr_animated(object)
  anim = object.anims[object.anim]
	-- NOTE: #array => size of the array
	frame = flr((time() * anim.spd) % #anim.frames) + 1

	if frame > #anim.frames then
		frame = 1
	end

	spr(anim.frames[frame],object.x, object.y, object.w/8, object.h/8, object.f)
end