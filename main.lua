Classe = require "classic"
require "jogo"
require "cenario"
require "mario"
require "nuvem"


function love.load()
    jogo = Jogo()
end

function love.update(dt)
    jogo:update(dt)
end

function love.draw()
    jogo:draw()
end