Ball = {}

function Ball:load()
    self.img = love.graphics.newImage("resources/ball.png")
    self.height = self.img:getHeight()
    self.width = self.img:getWidth()
    self.x = love.graphics.getWidth() / 2 - self.width
    self.y = love.graphics.getHeight() / 2 - self.height
    self.speed = 200
    self.xVel = -self.speed
    self.yVel = 0
end

function Ball:update(dt)
    Ball:move(dt)
    Ball:reflection()
    Ball:Boundary()
    Ball:Score()
end

function Ball:move(dt)
    self.x = self.x + self.xVel * dt
    self.y = self.y + self.yVel * dt
end

function Ball:reflection()
    if checkreflection(self, Player) then
        self.xVel = self.speed
        local middleBall = self.y + self.height / 2
        local middlePlayer = Player.y + Player.height / 2
        local reflectionposition = middleBall - middlePlayer
        self.yVel = reflectionposition * 5
    end

    if checkreflection(self, AI) then
        self.xVel = -self.speed
        local middleBall = self.y + self.height / 2
        local middleAI = AI.y + AI.height / 2
        local reflectionposition = middleBall - middleAI
        self.yVel = reflectionposition * 5
    end
end

function Ball:Score()
    if self.x < 0 then
        self.x = love.graphics.getWidth() / 2 - 20
        self.y = love.graphics.getHeight() / 2 - 20
        self.xVel = self.speed
        self.yVel = 0
        Score.ai = Score.ai + 1

    elseif self.x + self.width > love.graphics.getWidth() then
        self.x = love.graphics.getWidth() / 2 - 20
        self.y = love.graphics.getHeight() / 2 - 20
        self.xVel = -self.speed
        self.yVel = 0
        Score.player = Score.player + 1
    
    end

    if Score.ai == 1 then
        self.x = love.graphics.getWidth() / 2 - 20
        self.y = love.graphics.getHeight() / 2 - 20
        self.speed = 0
        self.yVel = 0
        self.xVel = 0
        Background.img = love.graphics.newImage("resources/defeated.png")
        if love.keyboard.isDown("r") then
            love.event.quit()
        end
    
    elseif Score.player == 1 then
        self.speed = 250
        AI.img = love.graphics.newImage("resources/bra.png")
    
    elseif Score.player == 2 then
        self.speed = 350
        AI.img = love.graphics.newImage("resources/ger.png")

    elseif Score.player == 3 then
        self.x = love.graphics.getWidth() / 2 - 20
        self.y = love.graphics.getHeight() / 2 - 20
        self.speed = 0
        self.yVel = 0
        self.xVel = 0
        Background.img = love.graphics.newImage("resources/win.png")
        if love.keyboard.isDown("r") then
            love.event.quit()
        end
    end
end

function Ball:Boundary()
    if self.y < 0 then 
        self.y = 0
        self.yVel = - self.yVel
    elseif self.y > love.graphics.getHeight() then
        self.y = love.graphics.getHeight()
        self.yVel = - self.yVel
    end
end

function Ball:draw()
    love.graphics.draw(self.img, self.x, self.y)
end