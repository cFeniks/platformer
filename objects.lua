    local mylib = {}

    function mylib:load()
        
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
                blocks.block1.y = 100
                blocks.block1.width = 100
                blocks.block1.height = 20
                blocks.block1.body = love.physics.newBody(world, blocks.block1.x, blocks.block1.y)
                blocks.block1.shape = love.physics.newRectangleShape(blocks.block1.width, blocks.block1.height)
                blocks.block1.fixture = love.physics.newFixture(blocks.block1.body, blocks.block1.shape)
                blocks.block1.fixture:setUserData("Block1")

            blocks.block2 = {}

                blocks.block2.x = 800
                blocks.block2.y = -20
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

            blocks.block4 = {}

                blocks.block4.x = -400
                blocks.block4.y = -20
                blocks.block4.width = 100
                blocks.block4.height = 10
                blocks.block4.body = love.physics.newBody(world, blocks.block4.x, blocks.block4.y)
                blocks.block4.shape = love.physics.newRectangleShape(blocks.block4.width, blocks.block4.height)
                blocks.block4.fixture = love.physics.newFixture(blocks.block4.body, blocks.block4.shape)
                blocks.block4.fixture:setUserData("Block4")

            blocks.block5 = {}

                blocks.block5.x = -600
                blocks.block5.y = -80
                blocks.block5.width = 100
                blocks.block5.height = 10
                blocks.block5.body = love.physics.newBody(world, blocks.block5.x, blocks.block5.y)
                blocks.block5.shape = love.physics.newRectangleShape(blocks.block5.width, blocks.block5.height)
                blocks.block5.fixture = love.physics.newFixture(blocks.block5.body, blocks.block5.shape)
                blocks.block5.fixture:setUserData("Block5")

            quadGrassGround = love.graphics.newQuad(0, 0, 16, 16, sprites)
            quadGrassTexturedGround1 = love.graphics.newQuad(16, 16, 16, 16, sprites)
            quadGrassTexturedGround2 = love.graphics.newQuad(16, 0, 16, 16, sprites)
            quadPlatform = love.graphics.newQuad(0, 0, 16, 16, platformSprite)
            quadFruit = love.graphics.newQuad(0, 0, 16, 16, fruitSprite)

            fruits = {}

                fruitColl = false
                drawFruit = true
                fruits.x = 607
                fruits.y = 209
                fruits.width = 16
                fruits.height = 16
                fruits.body = love.physics.newBody(world, fruits.x, fruits.y)
                fruits.shape = love.physics.newRectangleShape(fruits.width, fruits.height)
                fruits.fixture = love.physics.newFixture(fruits.body, fruits.shape)
                fruits.fixture:setSensor(true)
                fruits.fixture:setUserData("Apple")
            
            walls = {}
            
                walls.wallLeft = {}
                walls.wallLeft.x = -objects.platform.x
                walls.wallLeft.y = objects.platform.y/4
                walls.wallLeft.width = 100
                walls.wallLeft.height = 1000
                walls.wallLeft.body = love.physics.newBody(world, walls.wallLeft.x, walls.wallLeft.y)
                walls.wallLeft.shape = love.physics.newRectangleShape(walls.wallLeft.width, walls.wallLeft.height)
                walls.wallLeft.fixture = love.physics.newFixture(walls.wallLeft.body, walls.wallLeft.shape)
                walls.wallLeft.fixture:setUserData("wallLeft")

                walls.wallRight = {}
                walls.wallRight.x = objects.platform.x*2.2
                walls.wallRight.y = objects.platform.y/4
                walls.wallRight.width = 100
                walls.wallRight.height = 1000
                walls.wallRight.body = love.physics.newBody(world, walls.wallRight.x, walls.wallRight.y)
                walls.wallRight.shape = love.physics.newRectangleShape(walls.wallRight.width, walls.wallRight.height)
                walls.wallRight.fixture = love.physics.newFixture(walls.wallRight.body, walls.wallRight.shape)
                walls.wallRight.fixture:setUserData("wallRight")
        
    end
    
    return mylib