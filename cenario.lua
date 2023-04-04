Cenario = Classe:extend()


function Cenario:new()
    self.plataformas = {
        { x = 0,   y = 590, l = 800, a = 10, cor = { 0, 1, 0 }, mobile = false },
        { x = 700, y = 100, l = 50,  a = 10, cor = { 0, 1, 0 }, mobile = true, toRight = false },
        { x = 50,  y = 250, l = 50,  a = 10, cor = { 0, 1, 0 }, mobile = true, toRight = true },
        { x = 700, y = 400, l = 50,  a = 10, cor = { 0, 1, 0 }, mobile = true, toRight = false },
    }
end

function Cenario:update(dt)
    for i, plataforma in ipairs(self.plataformas) do
        if plataforma.x <= 0 then
            plataforma.toRight = true
        end
        if plataforma.x >= 750 then
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
        love.graphics.setColor(plataforma.cor)
        love.graphics.rectangle("fill", plataforma.x, plataforma.y, plataforma.l, plataforma.a)
        love.graphics.setColor(1, 1, 1)
    end
end
