function love.load()
	world = love.physics.newWorld(0, 9.81*32, true)
		world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	sprites = love.graphics.newImage("src/static/assets/sprites/world_tileset.png")
	fruitSprite = love.graphics.newImage("src/static/assets/sprites/fruit.png")

	camera = require 'src/libraries/camera'
	cam = camera()

	text       = ""
    persisting = 0
	objects = {}

	objects.platform = {}

	platformSprite = love.graphics.newImage("src/static/assets/sprites/platforms.png")
	objects.platform.x = love.graphics.getWidth()
	objects.platform.y = love.graphics.getHeight()
	objects.platform.body = love.physics.newBody(world, objects.platform.x/2, objects.platform.y+100/2)
	objects.platform.shape = love.physics.newRectangleShape(objects.platform.x+2000, objects.platform.y)
	objects.platform.fixture = love.physics.newFixture(objects.platform.body, objects.platform.shape, 1)
	objects.platform.fixture:setUserData("Platform")

	player = {}

	canJump = false
	jumpPower = -200
	player.x = love.graphics.getWidth()/2
	player.y = love.graphics.getHeight()/2
	player.width = 32
	player.height = 32
	player.body = love.physics.newBody(world, player.x, player.y, "dynamic")
	player.shape = love.physics.newRectangleShape(player.width, player.height)
	player.fixture = love.physics.newFixture(player.body, player.shape, 1)
	player.fixture:setUserData("Player")

	blocks = {}

	blocks.block1 = {}

	blocks.block1.x = 516
	blocks.block1.y = 0
	blocks.block1.width = 100
	blocks.block1.height = 20
	blocks.block1.body = love.physics.newBody(world, blocks.block1.x, blocks.block1.y)
	blocks.block1.shape = love.physics.newRectangleShape(blocks.block1.width, blocks.block1.height)
	blocks.block1.fixture = love.physics.newFixture(blocks.block1.body, blocks.block1.shape)
	blocks.block1.fixture:setUserData("Block1")

	blocks.block2 = {}

	blocks.block2.x = 800
	blocks.block2.y = -100
	blocks.block2.width = 100
	blocks.block2.height = 20
	blocks.block2.body = love.physics.newBody(world, blocks.block2.x, blocks.block2.y)
	blocks.block2.shape = love.physics.newRectangleShape(blocks.block2.width, blocks.block2.height)
	blocks.block2.fixture = love.physics.newFixture(blocks.block2.body, blocks.block2.shape)
	blocks.block2.fixture:setUserData("Block2")

	blocks.block3 = {}

	blocks.block3.x = 1200
	blocks.block3.y = -20
	blocks.block3.width = 200
	blocks.block3.height = 200
	blocks.block3.body = love.physics.newBody(world, blocks.block3.x, blocks.block3.y)
	blocks.block3.shape = love.physics.newRectangleShape(blocks.block3.width, blocks.block3.height)
	blocks.block3.fixture = love.physics.newFixture(blocks.block3.body, blocks.block3.shape)
	blocks.block3.fixture:setUserData("Block3")

	quadGrassGround = love.graphics.newQuad(0, 0, 16, 16, sprites)
	quadGrassTexturedGround1 = love.graphics.newQuad(16, 16, 16, 16, sprites)
	quadGrassTexturedGround2 = love.graphics.newQuad(16, 0, 16, 16, sprites)
	quadPlatform = love.graphics.newQuad(0, 0, 16, 16, platformSprite)
	quadFruit = love.graphics.newQuad(0, 0, 16, 16, fruitSprite)

	fruitColl = false
	fruits = {}
	fruits.x = 607
	fruits.y = 209
	fruits.width = 16
	fruits.height = 16
	fruits.body = love.physics.newBody(world, fruits.x, fruits.y)
	fruits.shape = love.physics.newRectangleShape(fruits.width, fruits.height)
	fruits.fixture = love.physics.newFixture(fruits.body, fruits.shape)
	fruits.fixture:setSensor(true)
	fruits.fixture:setUserData("Apple")

	drawFruit = true

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
		player.body:applyLinearImpulse(0, 100)
		love.load()
	end

	if love.keyboard.isDown("w") then
		if canJump or fruitColl then
			player.body:applyLinearImpulse(0, -200)
			fruitColl = false
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

		for i = -66, 100, 1 do
			for j = -66, 100, 1 do
				if j % 2 == 0 or i % 2 == 0 or i + j % 3 == 0 then
					love.graphics.draw(sprites, quadGrassTexturedGround2, 15*j, height)
				else
					love.graphics.draw(sprites, quadGrassTexturedGround1, 15*j, height)
				end
			end
			height = height+16
		end

		for i = -66, 100, 1 do
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