-- copy to create a new block

blocks.blockX = {}

        blocks.blockX.x = -400
        blocks.blockX.y = -20
        blocks.blockX.width = 100
        blocks.blockX.height = 100
        blocks.blockX.body = love.physics.newBody(world, blocks.blockX.x, blocks.blockX.y)
        blocks.blockX.shape = love.physics.newRectangleShape(blocks.blockX.width, blocks.blockX.height)
        blocks.blockX.fixture = love.physics.newFixture(blocks.blockX.body, blocks.blockX.shape)
        blocks.blockX.fixture:setUserData("BlockX")