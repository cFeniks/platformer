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
                jumpPower = -300
                player.x = love.graphics.getWidth()/2
                player.y = love.graphics.getHeight()/2
                player.width = 32
                player.height = 32
                player.body = love.physics.newBody(world, player.x, player.y, "dynamic")
                player.shape = love.physics.newRectangleShape(player.width, player.height)
                player.fixture = love.physics.newFixture(player.body, player.shape, 1)
                player.body:setAngularDamping(2)
                player.fixture:setUserData("Player")



            blocks = {}

                blocks.block1 = {}

                    blocks.block1.x = 716
                    blocks.block1.y = 100
                    blocks.block1.width = 100
                    blocks.block1.height = 20
                    blocks.block1.body = love.physics.newBody(world, blocks.block1.x, blocks.block1.y)
                    blocks.block1.shape = love.physics.newRectangleShape(blocks.block1.width, blocks.block1.height)
                    blocks.block1.fixture = love.physics.newFixture(blocks.block1.body, blocks.block1.shape)
                    blocks.block1.fixture:setUserData("Block1")

                blocks.block2 = {}

                    blocks.block2.x = 600
                    blocks.block2.y = 0
                    blocks.block2.width = 100
                    blocks.block2.height = 20
                    blocks.block2.body = love.physics.newBody(world, blocks.block2.x, blocks.block2.y)
                    blocks.block2.shape = love.physics.newRectangleShape(blocks.block2.width, blocks.block2.height)
                    blocks.block2.fixture = love.physics.newFixture(blocks.block2.body, blocks.block2.shape)
                    blocks.block2.fixture:setUserData("Block2")

                blocks.block3 = {}

                    blocks.block3.x = 200
                    blocks.block3.y = -5
                    blocks.block3.width = 200
                    blocks.block3.height = 200
                    blocks.block3.body = love.physics.newBody(world, blocks.block3.x, blocks.block3.y)
                    blocks.block3.shape = love.physics.newRectangleShape(blocks.block3.width, blocks.block3.height)
                    blocks.block3.fixture = love.physics.newFixture(blocks.block3.body, blocks.block3.shape)
                    blocks.block3.fixture:setUserData("Block3")

                blocks.block4 = {}

                    blocks.block4.x = -400
                    blocks.block4.y = -60
                    blocks.block4.width = 50
                    blocks.block4.height = 10
                    blocks.block4.body = love.physics.newBody(world, blocks.block4.x, blocks.block4.y)
                    blocks.block4.shape = love.physics.newRectangleShape(blocks.block4.width, blocks.block4.height)
                    blocks.block4.fixture = love.physics.newFixture(blocks.block4.body, blocks.block4.shape)
                    blocks.block4.fixture:setUserData("Block4")

                blocks.block5 = {}

                    blocks.block5.x = -600
                    blocks.block5.y = -160
                    blocks.block5.width = 150
                    blocks.block5.height = 10
                    blocks.block5.body = love.physics.newBody(world, blocks.block5.x, blocks.block5.y)
                    blocks.block5.shape = love.physics.newRectangleShape(blocks.block5.width, blocks.block5.height)
                    blocks.block5.fixture = love.physics.newFixture(blocks.block5.body, blocks.block5.shape)
                    blocks.block5.fixture:setUserData("Block5")

                blocks.block6 = {}

                    blocks.block6.x = -80
                    blocks.block6.y = -280
                    blocks.block6.width = 10
                    blocks.block6.height = 10
                    blocks.block6.body = love.physics.newBody(world, blocks.block6.x, blocks.block6.y)
                    blocks.block6.shape = love.physics.newRectangleShape(blocks.block6.width, blocks.block6.height)
                    blocks.block6.fixture = love.physics.newFixture(blocks.block6.body, blocks.block6.shape)
                    blocks.block6.fixture:setUserData("Block6")

                blocks.block7 = {}

                    blocks.block7.x = 180
                    blocks.block7.y = -350
                    blocks.block7.width = 10
                    blocks.block7.height = 10
                    blocks.block7.body = love.physics.newBody(world, blocks.block7.x, blocks.block7.y)
                    blocks.block7.shape = love.physics.newRectangleShape(blocks.block7.width, blocks.block7.height)
                    blocks.block7.fixture = love.physics.newFixture(blocks.block7.body, blocks.block7.shape)
                    blocks.block7.fixture:setUserData("Block7")

                blocks.block8 = {}

                    blocks.block8.x = 680
                    blocks.block8.y = -400
                    blocks.block8.width = 100
                    blocks.block8.height = 20
                    blocks.block8.body = love.physics.newBody(world, blocks.block8.x, blocks.block8.y)
                    blocks.block8.shape = love.physics.newRectangleShape(blocks.block8.width, blocks.block8.height)
                    blocks.block8.fixture = love.physics.newFixture(blocks.block8.body, blocks.block8.shape)
                    blocks.block8.fixture:setUserData("Block8")

            quadGrassGround = love.graphics.newQuad(0, 0, 16, 16, sprites)
            quadGrassTexturedGround1 = love.graphics.newQuad(16, 16, 16, 16, sprites)
            quadGrassTexturedGround2 = love.graphics.newQuad(16, 0, 16, 16, sprites)
            quadPlatform = love.graphics.newQuad(0, 0, 16, 16, platformSprite)
            quadFruit = love.graphics.newQuad(0, 0, 16, 16, fruitSprite)



            fruits = {}

                fruitColl = false
                

                fruits.fruit1 = {}

                    drawFruit1 = true
                    fruits.fruit1.x = 607
                    fruits.fruit1.y = 209
                    fruits.fruit1.width = 16
                    fruits.fruit1.height = 16
                    fruits.fruit1.body = love.physics.newBody(world, fruits.fruit1.x, fruits.fruit1.y)
                    fruits.fruit1.shape = love.physics.newRectangleShape(fruits.fruit1.width, fruits.fruit1.height)
                    fruits.fruit1.fixture = love.physics.newFixture(fruits.fruit1.body, fruits.fruit1.shape)
                    fruits.fruit1.fixture:setSensor(true)
                    fruits.fruit1.fixture:setUserData("Apple1")

                fruits.fruit2 = {}

                    drawFruit2 = true
                    fruits.fruit2.x = -285
                    fruits.fruit2.y = -240
                    fruits.fruit2.width = 16
                    fruits.fruit2.height = 16
                    fruits.fruit2.body = love.physics.newBody(world, fruits.fruit2.x, fruits.fruit2.y)
                    fruits.fruit2.shape = love.physics.newRectangleShape(fruits.fruit2.width, fruits.fruit2.height)
                    fruits.fruit2.fixture = love.physics.newFixture(fruits.fruit2.body, fruits.fruit2.shape)
                    fruits.fruit2.fixture:setSensor(true)
                    fruits.fruit2.fixture:setUserData("Apple2")

                fruits.fruit3 = {}

                    drawFruit3 = true
                    fruits.fruit3.x = 310
                    fruits.fruit3.y = -460
                    fruits.fruit3.width = 16
                    fruits.fruit3.height = 16
                    fruits.fruit3.body = love.physics.newBody(world, fruits.fruit3.x, fruits.fruit3.y)
                    fruits.fruit3.shape = love.physics.newRectangleShape(fruits.fruit3.width, fruits.fruit3.height)
                    fruits.fruit3.fixture = love.physics.newFixture(fruits.fruit3.body, fruits.fruit3.shape)
                    fruits.fruit3.fixture:setSensor(true)
                    fruits.fruit3.fixture:setUserData("Apple3")
            
            
            walls = {}

                lastCollision = ""
            
                walls.wallLeft = {}
                walls.wallLeft.x = -objects.platform.x*1.3
                walls.wallLeft.y = objects.platform.y/16
                walls.wallLeft.width = 100
                walls.wallLeft.height = 1000
                walls.wallLeft.body = love.physics.newBody(world, walls.wallLeft.x, walls.wallLeft.y)
                walls.wallLeft.shape = love.physics.newRectangleShape(walls.wallLeft.width, walls.wallLeft.height)
                walls.wallLeft.fixture = love.physics.newFixture(walls.wallLeft.body, walls.wallLeft.shape)
                walls.wallLeft.fixture:setUserData("wallLeft")

                walls.wallRight = {}
                walls.wallRight.x = objects.platform.x*2.33
                walls.wallRight.y = objects.platform.y/16
                walls.wallRight.width = 100
                walls.wallRight.height = 1000
                walls.wallRight.body = love.physics.newBody(world, walls.wallRight.x, walls.wallRight.y)
                walls.wallRight.shape = love.physics.newRectangleShape(walls.wallRight.width, walls.wallRight.height)
                walls.wallRight.fixture = love.physics.newFixture(walls.wallRight.body, walls.wallRight.shape)
                walls.wallRight.fixture:setUserData("wallRight")
        
    end
    
    return mylib