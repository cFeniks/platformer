    local mylib = {}

    function mylib:load()

        p = love.physics
        g = love.graphics

        function tablelength(table)
            local count = 0
            for _ in pairs(table) do count = count + 1 end
            return count
        end

        objects = {}

            objects.platform = {}

                platformSprite = g.newImage("src/static/assets/sprites/platforms.png")
                objects.platform.x = g.getWidth()
                objects.platform.y = g.getHeight()
                objects.platform.body = p.newBody(world, objects.platform.x/2, objects.platform.y+100/2)
                objects.platform.shape = p.newRectangleShape(objects.platform.x+2000, objects.platform.y)
                objects.platform.fixture = p.newFixture(objects.platform.body, objects.platform.shape, 1)
                objects.platform.fixture:setUserData("Platform")


            player = {}

                canJump = false
                jumpPower = -300
                player.x = g.getWidth()/2
                player.y = g.getHeight()/2
                player.width = 32
                player.height = 32
                player.body = p.newBody(world, player.x, player.y, "dynamic")
                player.shape = p.newRectangleShape(player.width, player.height)
                player.fixture = p.newFixture(player.body, player.shape, 1)
                player.body:setAngularDamping(2)
                player.fixture:setUserData("Player")


            blocks = {
                {}, {}, {}, {}, {}, {}, {}, {}
            }

                blocks[1] = {}
                    blocks[1].x = 716
                    blocks[1].y = 100
                    blocks[1].width = 100
                    blocks[1].height = 20

                blocks[2] = {}
                    blocks[2].x = 600
                    blocks[2].y = 0
                    blocks[2].width = 100
                    blocks[2].height = 20

                blocks[3] = {}
                    blocks[3].x = 200
                    blocks[3].y = -5
                    blocks[3].width = 200
                    blocks[3].height = 200

                blocks[4] = {}
                    blocks[4].x = -400
                    blocks[4].y = -60
                    blocks[4].width = 50
                    blocks[4].height = 10

                blocks[5] = {}
                    blocks[5].x = -600
                    blocks[5].y = -160
                    blocks[5].width = 150
                    blocks[5].height = 10

                blocks[6] = {}
                    blocks[6].x = -80
                    blocks[6].y = -280
                    blocks[6].width = 10
                    blocks[6].height = 10

                blocks[7] = {}
                    blocks[7].x = 180
                    blocks[7].y = -350
                    blocks[7].width = 10
                    blocks[7].height = 10

                blocks[8] = {}
                    blocks[8].x = 680
                    blocks[8].y = -400
                    blocks[8].width = 100
                    blocks[8].height = 20

            for i=1, tablelength(blocks) do
                local block = blocks[i]
                block.body = p.newBody(world, block.x, block.y)
                block.shape = p.newRectangleShape(block.width, block.height)
                block.fixture = p.newFixture(block.body, block.shape)
                block.fixture:setUserData("Block"..i)
            end

            quadGrassGround = g.newQuad(0, 0, 16, 16, sprites)
            quadGrassTexturedGround1 = g.newQuad(16, 16, 16, 16, sprites)
            quadGrassTexturedGround2 = g.newQuad(16, 0, 16, 16, sprites)
            quadPlatform = g.newQuad(0, 0, 16, 16, platformSprite)
            quadFruit = g.newQuad(0, 0, 16, 16, fruitSprite)


            fruits = {
                {}, {}, {}
            }

                fruitColl = false

                fruits[1] = {}
                    fruits[1].x = 607
                    fruits[1].y = 209

                fruits[2] = {}
                    fruits[2].x = -285
                    fruits[2].y = -240

                fruits[3] = {}
                    fruits[3].x = 310
                    fruits[3].y = -460

            for i=1, tablelength(fruits) do
                fruit=fruits[i]
                fruit.draw = true
                fruit.body = p.newBody(world, fruit.x, fruit.y)
                fruit.shape = p.newRectangleShape(16, 16)
                fruit.fixture = p.newFixture(fruit.body, fruit.shape)
                fruit.fixture:setSensor(true)
                fruit.fixture:setUserData("Apple"..i)
            end

                    
            walls = {}
        
                walls[1] = {}
                walls[1].x = -objects.platform.x*1.3

                walls[2] = {}
                walls[2].x = objects.platform.x*2.313

                for i=1, tablelength(walls) do
                    local wall = walls[i]
                    wall.body = p.newBody(world, walls[i].x, objects.platform.y/16)
                    wall.shape = p.newRectangleShape(100, 1000)
                    wall.fixture = p.newFixture(walls[i].body, walls[i].shape)
                    walls[i].fixture:setUserData("wallLeft" and 1 or "wallRight")
                end
    end
    
    return mylib