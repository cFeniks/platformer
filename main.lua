local obj = require ("objects")
function love.load()
	world = love.physics.newWorld(0, 9.81*32, true)
		world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	sprites = love.graphics.newImage("src/static/assets/sprites/world_tileset.png")
	fruitSprite = love.graphics.newImage("src/static/assets/sprites/fruit.png")

	camera = require 'src/libraries/camera'
	cam = camera()

	time = 0
	doTimer = true

	text       = ""
    persisting = 0
	
	obj:load()

	-- FPS lock for 60
	min_dt = 1/60
    next_time = love.timer.getTime()
	--

	text1 = ""
	text2 = ""
	love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
end

function love.update(dt)

	next_time = next_time + min_dt -- FPS

	world:update(dt)
	if doTimer then
		time = time + dt
		text1 = time
	else
		text1 = time
	end

	player.body:setLinearDamping(0.5)

	if love.keyboard.isDown("d") then
		player.body:applyLinearImpulse(8, 0)
	end

	if love.keyboard.isDown("a") then
		player.body:applyLinearImpulse(-8, 0)
	end

	if love.keyboard.isDown("r") then
		player.body:setPosition(player.x, player.y)
		player.body:setLinearVelocity(0, 0)
		player.body:setAngularVelocity(0, 0)
		love.load()
	end

	if love.keyboard.isDown("w") then
		if canJump or fruitColl then
			player.body:applyLinearImpulse(0, jumpPower)
			fruitColl = false
			canJump = false
			jumpPower=-300
		end
	end

	if player.body:isTouching(objects.platform.body) and player.body:isTouching(walls.wallLeft.body) then
		jumpPower=-125
		canJump=true
	else
		if player.body:isTouching(objects.platform.body) then
			jumpPower=-125
			canJump=true
		else
			jumpPower=-300
		end
		
	 end

	local followVarX, followVarY = player.body:getX(), player.body:getY()
	cam:lookAt(followVarX, followVarY)

	if player.body:getX() < -590 then
		cam:lockX(-590)
	elseif player.body:getX() > 1415 then
		cam:lockX(1415)
	end

	--debugging
	-- if string.len(text) > 1200 then    -- cleanup when 'text' gets too long
    --     text = ""
    -- end
	text=""
end

function love.draw()
	cam:attach()
	
		if drawFruit1 then
			love.graphics.draw(fruitSprite, quadFruit, 600, 200)
		end

		if drawFruit2 then
			love.graphics.draw(fruitSprite, quadFruit, -293, -250)
		end

		if drawFruit3 then
			love.graphics.draw(fruitSprite, quadFruit, 300, -470)
		end

		love.graphics.setColor(1, 1, 1)
		love.graphics.polygon("fill", player.body:getWorldPoints(player.shape:getPoints()))

		local height = objects.platform.y/2 + 50

		for i = 1, 50, 1 do
			for j = -66, 120, 1 do
				if j % 2 == 0 or i % 2 == 0 or i + j % 3 == 0 then
					love.graphics.draw(sprites, quadGrassTexturedGround2, 15*j, height)
				else
					love.graphics.draw(sprites, quadGrassTexturedGround1, 15*j, height)
				end
			end
			height = height+16
		end

		for i = -66, 120, 1 do
			love.graphics.draw(sprites, quadGrassGround, 15*i, objects.platform.y/2 + 50)
		end

		for _, block in pairs(blocks) do
			love.graphics.polygon("fill", block.body:getWorldPoints(block.shape:getPoints()))
		end
	cam:detach()
	
	-- FPS lock
	local cur_time = love.timer.getTime()
   	if next_time <= cur_time then
      	next_time = cur_time
      	return
   	end
   	love.timer.sleep(next_time - cur_time)
   	--

	-- debugging
	love.graphics.setColor(1, 1, 1)
	love.graphics.print(text, 10, 10)
	love.graphics.print(text1, 10, 10)
	love.graphics.print(text2, 100, 100)
	love.window.setTitle(tostring(love.timer.getFPS()))
end

-- debugging feature
-- function love.mousepressed(x, y, button, istouch)
--     player.body:setPosition(cam:mousePosition())
-- 	player.body:setLinearVelocity(0, 0)
-- 	player.body:setAngularVelocity(0, 0)

-- 	text1 = "clicked:   " .. "x: " .. x .. "  " .. "y: " .. y .."\n"
-- end

function beginContact(a, b, coll)
	x,y = coll:getNormal()
	local delta = 0.4
	if (y < 0 or (x >= 1-delta and x <= 1+delta) or (x >= -1-delta and x <= -1+delta))
		and a:getUserData() ~= "Platform" then
		canJump=false
	else
		canJump=true
	end

	if b:getUserData() == "Block8" then
		doTimer = false
		text1 = time
	end

	if b:getUserData() == "wallLeft" or b:getUserData() == "wallRight" then
		if (lastCollision == "wallLeft" or lastCollision == "wallRight")  then
			canJump = false
			end
	end

	if b:getUserData() == "Apple1" then
		fruitColl = true
		fruits.fruit1.body:destroy()
		drawFruit1=false
	end

	if b:getUserData() == "Apple2" then
		fruitColl = true
		fruits.fruit2.body:destroy()
		drawFruit2=false
	end

	if b:getUserData() == "Apple3" then
		fruitColl = true
		fruits.fruit3.body:destroy()
		drawFruit3=false
	end

	--debugging
    text = text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y
end

function endContact(a, b, coll)
	lastCollision = b:getUserData()

	persisting = 0    -- reset since they're no longer touching
	canJump=false

	-- debugging
    text = text.."\n"..a:getUserData().." uncolliding with "..b:getUserData()
end

function preSolve(a, b, coll)

	-- debugging
	if persisting == 0 then    -- only say when they first start touching
        text = text.."\n"..a:getUserData().." touching "..b:getUserData()
    elseif persisting < 20 then    -- then just start counting
        text = text.." "..persisting
    end

	

    persisting = persisting + 1    -- keep track of how many updates they've been touching for
end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)
	if b:getUserData() == "Platform" and (lastCollision == "wallLeft" or lastCollision == "wallRight") then
		canJump = true
	end
end