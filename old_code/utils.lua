function log(message, overwrite)
	printh(message, "logs", overwrite)
end

function t_sum()
    local sum = 0
    for k,v in pairs(t) do
        sum = sum + v
    end

    return sum
end

function has_value (tab, val)
	for index, value in ipairs(tab) do
			if value == val then
					return true
			end
		end
	return false
end

function max_cols(t)
	local max=0
	for i, line in ipairs(t) do
		local cols=0
		for s=1, #line do
			cols+=1
		end
		if (cols>max) max=cols
	end
	return max
end

function camx()
  return peek(0x5f28)
end

function camy()
  return peek(0x5f2a)
end

function camx2()
  return peek(0x5f29)
end

function camy2()
  return peek(0x5f2b)
end

-- smap - sspr for maps
-- @author Mot
-- @link https://www.lexaloffle.com/bbs/?tid=38931
--
-- Parameters are:
-- cx,cy,cw,ch Specify a region in the tile map. Measured in tiles.
-- sx,sy,sw,sh Region on the screen to map to. Mesured in pixels.
-- flipx,flipy Whether to flip horizontally and/or vertically.
-- layers Layer flags. Same as for map() = only render tiles with given flag.
--
-- You need to supply at least the c and s parameters.
function smap(cx,cy,cw,ch,sx,sy,sw,sh,flipx,flipy,layers)

	-- negative screen sizes
	if(sw<0)flipx=not flipx sx+=sw
	if(sh<0)flipy=not flipy sy+=sh
	sw,sh=abs(sw),abs(sh)

	-- delta
	local dx,dy=cw/sw,ch/sh

	-- apply flip
	if flipx then
	 cx+=cw
	 dx=-dx
	end
	if flipy then
	 cy+=ch
	 dy=-dy
	end

	-- clip
	if(sx<0)cx-=sx*dx sx=0
	if(sy<0)cy-=sy*dy sy=0
	if(sw>128)sw=128
	if(sh>128)sh=128

	-- render with tlines
	-- pick direction that results
	-- in fewest tline calls
	if sh<sw then
	 -- horizontal lines
	 for y=sy,sy+sh-1 do
		tline(sx,y,sx+sw-1,y,cx,cy,dx,0,layers)
		cy+=dy
	 end
	else
	 -- vertical lines
	 for x=sx,sx+sw-1 do
		tline(x,sy,x,sy+sh-1,cx,cy,0,dy,layers)
		cx+=dx
	 end
	end
 end