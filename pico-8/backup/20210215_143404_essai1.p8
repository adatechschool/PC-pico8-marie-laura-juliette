pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
		p={x=60,y=90,speed=4}
		bullets={}
		create_stars()
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
	--stars
	for s in all(stars) do
		pset(s.x,s.y,s.col)	
		end 
end

function update_stars()
 for s in all(stars) do
  s.y+=s.speed
  	
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
	stars={}
	for i=1,20 do
		new_star={
		 x= rnd(128),
		 y=rnd(128),
		 col=15,
		 speed=4
		}
		add(stars,new_star)
			
		end
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
000200003525035250332502e250272401f2301b2301922017210122100e2101021013210132000d200092000820007200062000620021200192002d200292001a20000000000000000000000000000000000000
