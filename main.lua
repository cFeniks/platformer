local obj = require ("objects")
function love.load()
	world = love.physics.newWorld(0, 9.81*32, true)
		world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	sprites = love.graphics.newImage("src/static/assets/sprites/world_tileset.png")
	fruitSprite = love.graphics.newImage("src/static/assets/sprites/fruit.png")

	camera = require 'src/libraries/camera'
	cam = camera()

	text       = ""
    persisting = 0
	
	obj:load()

	love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
end

function love.update(dt)
	world:update(dt)

	if love.keyboard.isDown("d") then
		player.body:applyLinearImpulse(10, 0)
	end

	if love.keyboard.isDown("a") then
		player.body:applyLinearImpulse(-10, 0)
	end

	if love.keyboard.isDown("r") then
		player.body:setPosition(player.x, player.y)
		player.body:setLinearVelocity(0, 0)
		player.body:setAngularVelocity(0, 0)
		love.load()
	end

	if love.keyboard.isDown("w") then
		if canJump or fruitColl then
			player.body:applyLinearImpulse(0, -300)
			fruitColl = false
			canJump = false
		end
	end

	cam:lookAt(player.body:getWorldPoints(player.shape:getPoints()))

	--debugging
	if string.len(text) > 1200 then    -- cleanup when 'text' gets too long
        text = ""
    end
end

function love.draw()
	cam:attach()
	
		if drawFruit then	
			love.graphics.draw(fruitSprite, quadFruit, 600, 200)
		end
		love.graphics.setColor(1, 1, 1)
		love.graphics.polygon("fill", player.body:getWorldPoints(player.shape:getPoints()))

		-- love.graphics.polygon("fill", objects.platform.body:getWorldPoints(objects.platform.shape:getPoints()))
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

		-- love.graphics.setColor(0.9, 0.31, 0.32)
		for i = -1, 1 do
			for j = -3, 2 do
				love.graphics.draw(platformSprite, quadPlatform, blocks.block1.x + 16*j, blocks.block1.y + 10*i)
			end
		end
		-- love.graphics.polygon("fill", blocks.block1.body:getWorldPoints(blocks.block1.shape:getPoints()))
		love.graphics.polygon("fill", blocks.block2.body:getWorldPoints(blocks.block2.shape:getPoints()))
		love.graphics.polygon("fill", blocks.block3.body:getWorldPoints(blocks.block3.shape:getPoints()))
		love.graphics.polygon("fill", blocks.block4.body:getWorldPoints(blocks.block4.shape:getPoints()))
		love.graphics.polygon("fill", blocks.block5.body:getWorldPoints(blocks.block5.shape:getPoints()))

		love.graphics.polygon("fill", walls.wallLeft.body:getWorldPoints(walls.wallLeft.shape:getPoints()))
		love.graphics.polygon("fill", walls.wallRight.body:getWorldPoints(walls.wallRight.shape:getPoints()))
		
	cam:detach()

	-- debugging
	love.graphics.setColor(1, 1, 1)
	love.graphics.print(text, 10, 10)
end

function beginContact(a, b, coll)
	x,y = coll:getNormal()
	local delta = 0.4
	if (y < 0 or (x >= 1-delta and x <= 1+delta) or (x >= -1-delta and x <= -1+delta))
		and a:getUserData() ~= "Platform" then
		canJump=false
	else
		canJump=true
	end

	if b:getUserData() == "Apple" then
		fruitColl = true
		fruits.body:destroy()
		drawFruit=false
	end

	--debugging
    text = text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y
end

function endContact(a, b, coll)
	persisting = 0    -- reset since they're no longer touching
	canJump=false


	if b:getUserData() == "wallLeft" or b:getUserData() == "wallRight" then
		canJump = true
	end                                    -- potential double jump feature


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

end