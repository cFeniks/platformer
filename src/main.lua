function love.load()
	world = love.physics.newWorld(0, 9.81*32)
	sprites = love.graphics.newImage("static/assets/sprites/world_tileset.png")

	camera = require 'libraries/camera'
	cam = camera()

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

	love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
end

function love.update(dt)
	world:update(dt)

	if love.keyboard.isDown("d") then
		if love.keyboard.isDown("w") then
			player.body:applyLinearImpulse(2, -2)
		else
			player.body:applyLinearImpulse(2, 0)
		end
	  elseif love.keyboard.isDown("a") then
		if love.keyboard.isDown("w") then
			player.body:applyLinearImpulse(-2, -2)
		else
			player.body:applyLinearImpulse(-2, 0)
		end
	elseif love.keyboard.isDown("r") then
		player.body:setPosition(player.x, player.y)
	elseif love.keyboard.isDown("w") then
		player.body:applyLinearImpulse(0, -10)
	end

	cam:lookAt(player.body:getWorldPoints(player.shape:getPoints()))
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
	cam:detach()
end