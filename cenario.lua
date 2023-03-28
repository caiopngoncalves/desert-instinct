Cenario = Classe:extend()


function Cenario:new()
    self.plataformas = {
        {x = 0, y=500, l=800, a=100, cor={0,1,0}},
        {x = 500, y=300, l=100, a=30, cor={0,1,0}}
    }
end

function Cenario:update(dt)

end

function Cenario:draw()
    for i, plataforma in ipairs(self.plataformas) do
        love.graphics.setColor(plataforma.cor)
        love.graphics.rectangle("fill", plataforma.x, plataforma.y, plataforma.l, plataforma.a)
        love.graphics.setColor(1,1,1)
    end
end