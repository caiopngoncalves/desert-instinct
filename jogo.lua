Jogo = Classe:extend()


function Jogo:new()
    cenario = Cenario()
    mario = Mario()
end

function Jogo:update(dt)
    for i, plataforma in pairs(cenario.plataformas) do
        if verificaColisao(mario, plataforma) then
            mario:ficaNoChao(plataforma.y)
        end
    end

    cenario:update(dt)
    mario:update(dt)
end

function Jogo:draw()
    cenario:draw()
    mario:draw()
end

function verificaColisao(A, B)
    if A.x < B.x + B.l and
        A.x + A.l > B.x and
        A.y < B.y + B.a and
        A.y + A.a > B.y then
            return true
    end
end