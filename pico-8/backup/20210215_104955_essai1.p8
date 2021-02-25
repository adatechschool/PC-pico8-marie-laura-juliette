pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
		p={x=60,y=90,speed=4}
end

function _update60()
	if (btn(➡️)) p.x+=1
	if (btn(⬅️)) p.x-=1
	if (btn(⬆️)) p.y-=1
	if (btn(⬇️)) p.y+=1
end

function _draw()
	cls(0)
	spr(1,p.x,p.y)
	
end


__gfx__
0000000000a00a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000d00d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000d0770d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000c2222c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000cc2772cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000d0770d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000dddddd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009dd9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000