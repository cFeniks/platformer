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


-- copy to create a new fruit

fruits.fruitX = {}

        fruits.fruitX.x = 607
        fruits.fruitX.y = 209
        fruits.fruitX.width = 16
        fruits.fruitX.height = 16
        fruits.fruitX.body = love.physics.newBody(world, fruits.fruitX.x, fruits.fruitX.y)
        fruits.fruitX.shape = love.physics.newRectangleShape(fruits.fruitX.width, fruits.fruitX.height)
        fruits.fruitX.fixture = love.physics.newFixture(fruits.fruitX.body, fruits.fruitX.shape)
        fruits.fruitX.fixture:setSensor(true)
        fruits.fruitX.fixture:setUserData("Apple")