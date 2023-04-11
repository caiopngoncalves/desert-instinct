Jogo = Classe:extend()


function Jogo:new()
    self.background = love.graphics.newImage("background.png")
    self.point = 0
    cenario = Cenario()
    mario = Mario()
    nuvem = Nuvem()
end

function Jogo:update(dt)
    for i, plataforma in pairs(cenario.plataformas) do
        if verificaColisao(mario, plataforma) then
            mario:ficaNoChao(plataforma.y)
            --[[         else
            if verificaColisaoBaixoPlataforma(mario, plataforma) then
                --mario.y = plataforma.y
            end ]]
        end
    end

    if verificaColisao(mario, nuvem) then
        nuvem.pointed = true
    end
    for i, gota in pairs(nuvem.gotas) do
        if verificaColisao(mario, gota) and gota.active then
            self.point = self.point + 1
            gota.active = false
        end
    end

    cenario:update(dt)
    mario:update(dt)
    nuvem:update(dt)
end

function Jogo:draw()
    love.graphics.draw(self.background, -100, -100)
    cenario:draw()
    mario:draw()
    nuvem:draw()
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("pontos:" .. self.point .. "    meta: 1000", 30, 30, 0, 2, 2)
    love.graphics.setColor(1, 1, 1)
end

function verificaColisao(A, B)
    if A.x < B.x + B.l and
        A.x + A.l > B.x and
        A.y < B.y + B.a and
        A.y + A.a > B.y then
        return true
    end
end

function verificaColisaoBaixoPlataforma(A, B)
    if A.x < B.x + B.l and
        A.x + A.l > B.x and
        A.y + A.a < B.y and
        A.y + A.a > B.y - 1 then
        return true
    end
end
