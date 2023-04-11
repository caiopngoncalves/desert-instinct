Nuvem = Classe:extend()


function Nuvem:new()
    self.drop = love.graphics.newImage("drop.png")
    self.clound1 = love.graphics.newImage("cloud1.png")
    self.clound2 = love.graphics.newImage("cloud2.png")
    self.clound3 = love.graphics.newImage("cloud3.png")
    self.currentSprite = self.clound1
    self.showCircle = false
    self.elapsedTime = 0
    self.choveTimer = 0
    self.x = love.math.random(100, 700)
    self.y = love.math.random(100, 500)
    self.xOnRaining = 0
    self.l = self.currentSprite:getWidth() * 0.5
    self.a = self.currentSprite:getHeight() * 0.5
    self.toRight = true
    self.pointed = false
    self.contadorGotas = 0
    self.gotas =
    {
        { x = 50, y = 49, l = self.drop:getWidth() * 0.1, a = self.drop:getHeight() * 0.1, active = false },
        { x = 50, y = 49, l = self.drop:getWidth() * 0.1, a = self.drop:getHeight() * 0.1, active = false },
        { x = 50, y = 49, l = self.drop:getWidth() * 0.1, a = self.drop:getHeight() * 0.1, active = false },
        { x = 50, y = 49, l = self.drop:getWidth() * 0.1, a = self.drop:getHeight() * 0.1, active = false },
        { x = 50, y = 49, l = self.drop:getWidth() * 0.1, a = self.drop:getHeight() * 0.1, active = false }
    }
end

function Nuvem:update(dt)
    local time = love.timer.getTime()
    if time % 0.5 < 0.25 then
        self.currentSprite = self.clound1
    elseif time % 0.5 < 0.5 then
        self.currentSprite = self.clound2
    else
        self.currentSprite = self.clound3
    end

    self.elapsedTime = self.elapsedTime + dt
    self.contadorGotas = self.contadorGotas + dt
    if self.elapsedTime >= 2 then
        self.showCircle = not self.showCircle
        self.elapsedTime = 0
        if self.showCircle then
            self.x = love.math.random(100, 700)
            self.y = love.math.random(100, 500)
        end
    end

    if self.pointed then
        self.elapsedTime = 0
        self.choveTimer = self.choveTimer + dt
        self:evapora(dt)
        if (self.choveTimer >= 2.5) then
            self:chove(dt)
        end
    end

    if self.choveTimer >= 13 then
        self.pointed = false
        self.choveTimer = 0
        for i, gota in ipairs(self.gotas) do
            gota.active = false
            gota.y = 49
        end
    end
end

function Nuvem:draw()
    for i, gota in ipairs(self.gotas) do
        if (gota.active) then
            love.graphics.draw(self.drop, gota.x, gota.y, 0, 0.1, 0.1)
        end
    end
    if self.showCircle then
        love.graphics.draw(self.currentSprite, self.x, self.y, 0, 0.5, 0.5)
    end
end

function Nuvem:evapora(dt)
    if self.y > 20 then
        self.y = self.y + -500 * dt
    end
end

function Nuvem:chove(dt)
    if self.y <= 50 then
        if self.toRight then
            self.x = self.x + 300 * dt
            if self.x >= 800 - self.a then
                self.toRight = false
            end
        else
            self.x = self.x - 300 * dt
            if self.x <= 0 then
                self.toRight = true
            end
        end
        for i, gota in ipairs(self.gotas) do
            if self.choveTimer >= 2.5 + i then
                if gota.y < 50 then
                    gota.x = self.x
                end
                gota.active = true
                gota.y = gota.y + 300 * dt
            end
        end
    end
    --[[     for i, gota in ipairs(self.gotas) do
        if gota.y >= 600 then
            gota.active = false
            if i == 4 then
                self.pointed = false
            end
        end
    end ]]
end
