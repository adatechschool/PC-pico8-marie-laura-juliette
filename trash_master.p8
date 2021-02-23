pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
	p={x=60,
	y=110,
	speed=2,
	hastrash=0,
	miroir=false}
	throwing_count = 0
	throwing = false
	trashtab={
		{
		x=90,
		y=110,
		speed=150,
		number=1,
		sprite=16
		},
		{
		x=100,
		y=115,
		speed=150,
		number=1, 
		sprite=17
		},
		{
		x=40,
		y=110,
		speed=150,
		number=1, 
		sprite=18
		},
		{
		x=20,
		y=112,
		speed=150,
		number=2,
		sprite=19
		},
		{
		x=100,
		y=80,
		speed=40,
		number=2,
		sprite=20
		},
		{
		x=10,
		y=90,
		speed=150,
		number=2,
		sprite=21
		},
		{
		x=43,
		y=76,
		speed=150,
		number=1,
		sprite=32
		},
		{
		x=85,
		y=85,
		speed=150,
		number=2,
		sprite=33
		},
		{
		x=13,
		y=55,
		speed=150,
		number=1,
		sprite=34
		},
		{
		x=39,
		y=62,
		speed=150,
		number=1,
		sprite=35 
		},
		{
		x=59,
		y=90,
		speed=150,
		number=2,
		sprite=36
		}
	   }
	
green_bin={x=20,y=15,srite=10}
yellow_bin={x=80,y=15,srite=64}
explosions={}
erreurs =0
end

function _update()
	player_moves()
	grab()
	movetrash()
	update_trash1()
	update_trash2()
	update_explosions()
end

function _draw()
	cls()
	map(0,0,0,0,128,64)
--player
	spr(6,p.x,p.y,2,2,p.miroir)
--verte
	spr(10,20,15,4,4)
--jaune
	spr(64,80,15,4,4)
--dechets
 for t in all(trashtab) do
	spr(t.sprite,t.x,t.y)	
 end
--explosions
draw_explosions()
--erreurs
print ("erreurs:",2,2,10)
print (erreurs,2,8,10)
end
--end

-->8
--collision-p-t

--trash
--1:recyclable
--2:pas recyclable 

function collision(a,b)  
	if a.x>b.x+16
	or a.y>b.y+16
	or a.x+16<b.x
	or a.y+16<b.y then
		return false
	else
		return true
	end
end 

function grab()
	for i,t in pairs(trashtab) do	
 	if collision(p,t)==true	
 	and p.hastrash==0
 	then
 		p.hastrash = i
 	elseif p.hastrash==i 
 	and throwing == false	then
 		t.x = p.x+5
 		t.y = p.y-5		
		end
	end
end


function shoottrash()	
	if p.hastrash>0 then
	throwing = true
	throwing_count=100
	p.hastrash = 0
	end
end

function movetrash()
	if throwing == true then
		throwing_count -=1
		trashtab[p.hastrash].y-=1
		if throwing_count == 0 then
			throwing = false
		end	
	end
end		
-->8
--player
function player_moves()
	if (btn(➡️)) p.x+=p.speed
	if (btn(⬅️))	p.x-=p.speed
	if (btn(⬆️)) p.y-=p.speed
	if (btn(⬇️)) p.y+=p.speed
	if (btnp(❎)) shoottrash()

	if (p.x<0) p.x=0
 if (p.y<0) p.y=0
 if (p.x>120) p.x=120
 if (p.y>115) p.y=115

end
-->8
--collision-t-bin
function collision_bin(t,b)  
	if t.x>b.x+32
	or t.y>b.y+32
	or t.x+32<b.x
	or t.y+32<b.y then
		return false
	else
		return true
	end
end 

function update_trash1()
	for i,t in pairs(trashtab) do
		if trashtab[i].number==1
		and collision_bin(t,green_bin)
		then
		create_explosions(t.x,t.y)
		del (trashtab,trashtab[i])
		erreurs +=1
		end
	end
end			
			
function update_trash2()			
		for i,t in pairs(trashtab) do
			if trashtab[i].number==2
			and collision_bin(t,yellow_bin) 
			then
			create_explosions(t.x,t.y)
			del (trashtab,trashtab[i])
			erreurs +=1
		end
	end
end
-->8
--explosion
function create_explosions(x,y)
	add(explosions,{
		x = x,
		y = y,
		timer = 0
	})
	sfx(0)
	end
	
function update_explosions()
	for boom in all(explosions) do
	boom.timer +=1
		if boom.timer == 13 then
			del(explosions,boom)
		end
	end
end

function draw_explosions()
	for boom in all(explosions) do
		circ(boom.x, boom.y,
		 boom.timer/1.5, 8+boom.timer%3)
	end
end	  


__gfx__
000000003333333333333333333373733333333333333333000000cccc00cc00000000ccc00cc000000000000000000000000000000000000000000000000000
00000000333333333333333333333e333333333333333333000000cccc00cc00000000ccc00cc000000000000000000000000000000000000000000000000000
00700700333333333333333333337373333b3333bb333bb3000ccccccccccc00000cccccccccc000000000000000000000000000000000000000000000000000
00077000333333333933333333333333b33b3333bbb3bbb30ccccccccccccc000cccccccccccc000000000000000000000000000000000000000000000000000
00077000333333339a93333333737333bb3b3bb33bb3bb33cccccccc444444cccccccccc444444cc000000000000000000000000000000000000000000000000
007007003333333339333333333a33333bbbbb33333b3333cccc4444444444cccccc4444444444cc000000bbbbbbbbbbbbbbbbbb000000000000000000000000
0000000033333333333333333373733333bbb333333b33330cccc441144411cc0cccc441144411cc000000bbbbbbbbbbbbbbbbbb000000000000000000000000
0000000033333333333333333333333333333333333b33330cccc441144411cc0cccc441144411cc000000bbbbbbbbbbbbbbbbbb000000000000000000000000
000020000000800077777777007000000008000077000077000cc44444444400000cc44444444400000000555555555555555555000000000000000000000000
00001000000800007cc70007070000070078800077000077000cc44444444400000cc44444444400000000555555555555555555000000000000000000000000
00011100008000007cc7777770000070007780000c0000c000002222222200000000222222220000000000555555555555555555000000000000000000000000
00011100080000007cc70007cccccc00007770000c0000c000002222222200000000222222220000000000555555555555555555000000000000000000000000
000661000888880077777777c6666c00007770000c0000c000002222222200000000222222220000000000555555555555555555000000000000000000000000
000661000777770070000007cccccc00000700000c0000c000002222222200000077222222220000000000555555555555555555000000000000000000000000
000111000777770077777777c6666c07007000007700007700770000000077000077000000770000000000555555555555555555000000000000000000000000
000111000888880070000077cccccc70070000007700007700770000000077000000000000770000000000555555555555555555000000000000000000000000
00066000a0a0a0a00777777000000000700000700000000000000000000000000000000000000000000000555555555555555555000000000000000000000000
00060000a0a0a0a07077770700555500770007700000000000000000000000000000000000000000000000555555555555555555000000000000000000000000
07767700a0a0a0a07707707700666600070007000000000000000000000000000000000000000000000000555555555555555555000000000000000000000000
07777700888888887770077700666600770007700000000000000000000000000000000000000000000000555555555555555555000000000000000000000000
033333008aa88aa87777777700667700000400700000000000000000000000000000000000000000000000555555555555555555000000000000000000000000
033333008a8aa8a87777777700667700004440000000000000000000000000000000000000000000000000555555555555555555000000000000000000000000
077777008a8888a87777777700666600044444000000000000000000000000000000000000000000000000555555555555555555000000000000000000000000
007770008a8888a87777777700666600444444400000000000000000000000000000000000000000000000555555555555555555000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000555555555555555555000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000555555555555555555000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000555555555555555555000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000555555555555555555000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000555555555555555555000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000555555555555555555000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000555555555555555555000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000555555555555555555000000000000000000000000
000000000000000000000000000000000000000000000000bbbbbbb0000000000000000000000000aaaaaaa00000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000bbbbbbbbb0000000000000000000000aaaaaaaaaa00000000000000000000000000000000000000000
000000000000000000000000000000000000000000bbbbbbbbbbb000000000000000000000aaaaaaaaaaaa000000000000000000000000000000000000000000
0000000000000000000000000000000000000000bbbbbbbbbbb00000000000000000000aaaaaaaaaaaa000000000000000000000000000000000000000000000
00000000000000000000000000000000000000bbbbbbbbbbb000000000000000000000aaaaaaaaaa000000000000000000000000000000000000000000000000
000000aaaaaaaaaaaaaaaaaa0000000000000bbbbbbbb000000000000000000000000aaaaaaaa000000000000000000000000000000000000000000000000000
000000aaaaaaaaaaaaaaaaaa0000000000000bbbbbb00000000000000000000000000aaaaa000000000000000000000000000000000000000000000000000000
000000aaaaaaaaaaaaaaaaaa0000000000000bbbb0000000000000000000000000000aaaa0000000000000000000000000000000000000000000000000000000
00000055555555555555555500000000000000555555555555555555000000000000005555555555555555550000000000000000000000000000000000000000
00000055555555555555555500000000000000555555555555555555500000000000005555555555555555555000000000000000000000000000000000000000
00000055555555555555555500000000000005555555555555555555550000000000055555555555555555555500000000000000000000000000000000000000
00000055555555555555555500000000000005555555555555555555550000000000055555555555555555555500000000000000000000000000000000000000
00000055555555555555555500000000000055555555555555555555555000000000555555555555555555555550000000000000000000000000000000000000
00000055555555555555555500000000000055555555555555555555555000000000555555555555555555555550000000000000000000000000000000000000
00000055555555555555555500000000000055555555555555555555555000000000555555555555555555555550000000000000000000000000000000000000
00000055555555555555555500000000000555555555555555555555555000000005555555555555555555555550000000000000000000000000000000000000
00000055555555555555555500000000000555555555555555555555555000000005555555555555555555555550000000000000000000000000000000000000
00000055555555555555555500000000000555555555555555555555555000000005555555555555555555555550000000000000000000000000000000000000
00000055555555555555555500000000000555555555555555555555555000000005555555555555555555555550000000000000000000000000000000000000
00000055555555555555555500000000000555555555555555555555555000000005555555555555555555555550000000000000000000000000000000000000
00000055555555555555555500000000000555555555555555555555550000000005555555555555555555555500000000000000000000000000000000000000
00000055555555555555555500000000000555555555555555555555550000000005555555555555555555555500000000000000000000000000000000000000
00000055555555555555555500000000000555555555555555555555550000000005555555555555555555555500000000000000000000000000000000000000
00000055555555555555555500000000000055555555555555555555500000000000555555555555555555555000000000000000000000000000000000000000
00000055555555555555555500000000000005555555555555555555500000000000055555555555555555555000000000000000000000000000000000000000
00000055555555555555555500000000000005555555555555555555500000000000055555555555555555555000000000000000000000000000000000000000
00000055555555555555555500000000000000555555555555555555000000000000005555555555555555550000000000000000000000000000000000000000
00000055555555555555555500000000000000555555555555555555000000000000005555555555555555550000000000000000000000000000000000000000
00000055555555555555555500000000000000555555555555555555000000000000005555555555555555550000000000000000000000000000000000000000
00000055555555555555555500000000000000555555555555555555000000000000005555555555555555550000000000000000000000000000000000000000
00000055555555555555555500000000000000555555555555555555000000000000005555555555555555550000000000000000000000000000000000000000
00000055555555555555555500000000000000555555555555555555000000000000005555555555555555550000000000000000000000000000000000000000
00000000000000001010101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000
__map__
0101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0104010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0105010101010104010101010101050101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010501010101010101010101010101010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010501010101010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010401010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010000000101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000300000c5300e5100f5101051011510135201652018520195201b5201d5201f5302254026560295602b5602c5602d5602f560305603056031550335503355034550345503455035550365503c5500000000000
