function love.load()
	world = love.physics.newWorld(0, 9.81*32)
		world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	sprites = love.graphics.newImage("src/static/assets/sprites/world_tileset.png")

	camera = require 'src/libraries/camera'
	cam = camera()

	text       = ""
    persisting = 0

	objects = {}

	objects.platform = {}

	objects.platform.x = love.graphics.getWidth()
	objects.platform.y = love.graphics.getHeight()
	objects.platform.body = love.physics.newBody(world, objects.platform.x/2, objects.platform.y+100/2)
	objects.platform.shape = love.physics.newRectangleShape(objects.platform.x+2000, objects.platform.y)
	objects.platform.fixture = love.physics.newFixture(objects.platform.body, objects.platform.shape, 1)

	player = {}

	player.x = love.graphics.getWidth()/2
	player.y = love.graphics.getHeight()/2
	player.width = 32
	player.height = 32
	player.body = love.physics.newBody(world, player.x, player.y, "dynamic")
	player.shape = love.physics.newRectangleShape(player.width, player.height)
	player.fixture = love.physics.newFixture(player.body, player.shape, 1)

	quadGrassGround = love.graphics.newQuad(0, 0, 16, 16, sprites)
	quadGrassTexturedGround1 = love.graphics.newQuad(16, 16, 16, 16, sprites)
	quadGrassTexturedGround2 = love.graphics.newQuad(16, 0, 16, 16, sprites)

	blocks = {}

	blocks.block1 = {}

	blocks.block1.x = 500
	blocks.block1.y = 200
	blocks.block1.width = 100
	blocks.block1.height = 20
	blocks.block1.body = love.physics.newBody(world, blocks.block1.x, blocks.block1.y)
	blocks.block1.shape = love.physics.newRectangleShape(blocks.block1.width, blocks.block1.height)
	blocks.block1.fixture = love.physics.newFixture(blocks.block1.body, blocks.block1.shape)

	love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
end

function love.update(dt)
	local distance, x1, y1, x2, y2 = love.physics.getDistance(objects.platform.fixture, player.fixture)
	local onGround = y2 > y1 and true or false;
	world:update(dt)

	if love.keyboard.isDown("d") then
		player.body:applyLinearImpulse(10, 0)
	end

	if love.keyboard.isDown("a") then
		player.body:applyLinearImpulse(-10, 0)
	end

	if love.keyboard.isDown("r") then
		player.body:setPosition(player.x, player.y)
	end

	if love.keyboard.isDown("w") then
		if y2 < y1 and not onGround then
			player.body:applyLinearImpulse(0, 40)
		else
			player.body:applyLinearImpulse(0, -200)
		end
	end

	cam:lookAt(player.body:getWorldPoints(player.shape:getPoints()))

	--debugging
	if string.len(text) > 768 then    -- cleanup when 'text' gets too long
        text = ""
    end
end

function love.draw()
	cam:attach()

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

		love.graphics.polygon("fill", blocks.block1.body:getWorldPoints(blocks.block1.shape:getPoints()))
	cam:detach()

	--- debugging
	love.graphics.print(text, 10, 10)
end

function beginContact(a, b, coll)
	
end

function endContact(a, b, coll)
	
end

function preSolve(a, b, coll)
	
end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)
	
end