function love.load()
	player = {}
	objects = {}

	camera = require 'libraries/camera'
	cam = camera()

	love.physics.setMeter(40)
	world = love.physics.newWorld()

	HEIGHT = love.graphics.getHeight()
	WIDTH = love.graphics.getWidth()

	objects.platform = {}

	objects.platform.width = WIDTH + 500
	objects.platform.height = HEIGHT
	objects.platform.x = WIDTH / 2
	objects.platform.y = objects.platform.height
	objects.platform.body = love.physics.newBody(world, objects.platform.x, objects.platform.y, "static")
	objects.platform.shape = love.physics.newRectangleShape(objects.platform.width, objects.platform.height)
	objects.platform.fixture = love.physics.newFixture(objects.platform.body, objects.platform.shape)



	player.x = WIDTH / 2
	player.y = HEIGHT / 2
	player.width = 32
	player.height = 32
	player.speed = 200
	--player.img = love.graphics.newImage('static/purple.png')
	player.ground = player.y
	player.y_velocity = 0
	player.jump_height = -300
	player.gravity = -500
	player.body = love.physics.newBody(world, player.x, player.y, "dynamic")
	player.shape = love.physics.newRectangleShape(player.width, player.height)
	player.fixture = love.physics.newFixture(player.body, player.shape, 1)


	objects.block1 = {}

	objects.block1.x = love.graphics.getWidth() / 2
	objects.block1.y = love.graphics.getHeight() / 2
	objects.block1.width = 100
	objects.block1.height = 50
	objects.block1.body = love.physics.newBody(world, objects.block1.x, objects.block1.y, "static")
	objects.block1.shape = love.physics.newRectangleShape(objects.block1.width, objects.block1.height)
	objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 1)

	love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
	
end

function love.update(dt)
	if love.keyboard.isDown('d') then
		player.body:applyForce(900, 0)
	elseif love.keyboard.isDown('a') then
		player.body:applyForce(-900, 0)
	end

	if love.keyboard.isDown('w') then
		if player.y_velocity == 0 then
			player.y_velocity = player.jump_height
		end
	end

	if love.keyboard.isDown('r') then
		player.x = love.graphics.getWidth() / 2
	end

	if player.y > player.ground then
		player.y_velocity = 0
    	player.y = player.ground
	end

	if player.y_velocity ~= 0 then
		player.y = player.y + (player.y_velocity * dt)
		player.y_velocity = player.y_velocity - (player.gravity * dt)
	end

	
		cam:lookAt(player.x, player.y)
end

function love.draw()
	love.graphics.setColor(0.22, 0.16, 0.22)
	love.graphics.polygon("fill", player.body:getWorldPoints(player.shape:getPoints()))

	cam:attach()

		love.graphics.setColor(0.28, 0.63, 0.05)
		-- draw a "filled in" polygon using the ground's coordinates
		love.graphics.polygon("fill", objects.platform.body:getWorldPoints(
							objects.platform.shape:getPoints()))
	-- love.graphics.setColor(0.28, 0.63, 0.05)
	-- 	for _, body in pairs(world:getBodies()) do
	-- 		for _, fixture in pairs(body:getFixtures()) do
	-- 			local shape = fixture:getShape()
		
	-- 			if shape:typeOf("CircleShape") then
	-- 				local cx, cy = body:getWorldPoints(shape:getPoint())
	-- 				love.graphics.circle("fill", cx, cy, shape:getRadius())
	-- 			elseif shape:typeOf("PolygonShape") then
					
	-- 				love.graphics.polygon("fill", body:getWorldPoints(shape:getPoints()))
	-- 			else	
	-- 				love.graphics.line(body:getWorldPoints(shape:getPoints()))
	-- 			end
	-- 		end
	-- 	end
		cam:detach()	
end