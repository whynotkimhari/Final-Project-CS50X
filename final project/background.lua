Background = {}

function Background:load()
    self.img = love.graphics.newImage("resources/WCbg.png")
end

function Background:update(dt)
end

function Background:draw()
    love.graphics.draw(self.img, 0, 0)
end