Cenario = Classe:extend()


function Cenario:new()
    self.plataformSprite = love.graphics.newImage("plataform.png")
    self.groundSprite = love.graphics.newImage("ground.jpg")
    self.plataformas = {
        {
            x = 0,
            y = 590,
            l = 800,
            a = 20,
            cor = { 0,
                1, 0 },
            mobile = false
        },
        {
            x = 50,
            y = 210,
            l = self.plataformSprite:getWidth() * 0.15,
            a = self.plataformSprite:getHeight() * 0.15,
            cor = {
                0, 1, 0 },
            mobile = true,
            toRight = true
        },
        {
            x = 700,
            y = 400,
            l = self.plataformSprite:getWidth() * 0.15,
            a = self.plataformSprite:getHeight() * 0.15,
            cor = {
                0, 1, 0 },
            mobile = true,
            toRight = false
        },
    }
end

function Cenario:update(dt)
    for i, plataforma in ipairs(self.plataformas) do
        if plataforma.x <= 0 then
            plataforma.toRight = true
        end
        if plataforma.x >= 800 - plataforma.l then
            plataforma.toRight = false
        end
        if plataforma.mobile then
            if plataforma.toRight then
                plataforma.x = plataforma.x + dt * 100
            else
                plataforma.x = plataforma.x - dt * 100
            end
        end
    end
end

function Cenario:draw()
    for i, plataforma in ipairs(self.plataformas) do
        if plataforma.mobile then
            love.graphics.draw(self.plataformSprite, plataforma.x, plataforma.y, 0, 0.15, 0.15)
        else
            love.graphics.draw(self.groundSprite, plataforma.x, plataforma.y)
        end
    end
end
