pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
		p={x=60,y=90,speed=4}
		bullets={}
end

function _update60()
	if (btn(➡️)) p.x+=1
	if (btn(⬅️)) p.x-=1
	if (btn(⬆️)) p.y-=1
	if (btn(⬇️)) p.y+=1
	if (btnp(❎)) shoot()
	update_bullets()
end

function _draw()
	cls(0)
	--vaisseau
	spr(1,p.x,p.y)
	--bullets
	for b in all(bullets) do
	 spr(2,b.x,b.y)
	end
end
-->8
--bullets

function shoot()
	new_bullet={
		x=p.x,
		y=p.y, 
		speed=5
	}
	add(bullets, new_bullet)
	sfx(0)
end

function update_bullets()
	for b in all(bullets) do
		b.y-=b.speed
		end
end
-->8
--stars
function create_stars()

end
__gfx__
0000000000a00a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000d00d000090900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000d0770d000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000c2222c000a0900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000cc2772cc0090a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000d0770d00090900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000dddddd00000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009dd90000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000032050300502c050260502004019030110200e0100d0100c0100b0200a0200a010090100905009050090500605000000000000000000000000000000000000000000000000000000000000000000
