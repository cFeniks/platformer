platform = {}
player = {}

function love.load()
	platform.width = love.graphics.getWidth()
	platform.height = love.graphics.getHeight()

	platform.x = 0
	platform.y = platform.height / 2

	player.x = love.graphics.getWidth() / 2
	player.y = love.graphics.getHeight() / 2

	player.speed = 200

	player.img = love.graphics.newImage('purple.png')

	player.ground = player.y
	
	player.y_velocity = 0

	player.jump_height = -300
	player.gravity = -500
end

function love.update(dt)
	if love.keyboard.isDown('d') then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
			player.x = player.x + (player.speed * dt)
		end
	elseif love.keyboard.isDown('a') then
		if player.x > 0 then 
			player.x = player.x - (player.speed * dt)
		end
	end

	if love.keyboard.isDown('space') then
		if player.y_velocity == 0 then
			player.y_velocity = player.jump_height
		end
	end

	if player.y_velocity ~= 0 then
		player.y = player.y + player.y_velocity * dt
		player.y_velocity = player.y_velocity - player.gravity * dt
	end

	if player.y > player.ground then
		player.y_velocity = 0
    	player.y = player.ground
	end
end

function love.draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)

	love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 0, 32)
end