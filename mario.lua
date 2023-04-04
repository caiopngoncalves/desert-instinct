Mario = Classe:extend()


function Mario:new()
    self.x, self.y = 30, 30
    self.l, self.a = 10, 30
    self.gravidade = 2
    self.vel_pulo = 5
    self.vel_y = 0
    self.vel_andar = 500
    self.tempo_pulo = 0
    self.tempo_pulo_max = 0
    self.esta_no_chao = false
    self.pulou_ultimo_frame = false
end

function Mario:update(dt)
    if love.keyboard.isDown("space") then
        if self.esta_no_chao then
            self.vel_y = -10
            self.pulou_ultimo_frame = true
            self.esta_no_chao = false
            self.tempo_pulo = 0
        else -- não está no chao
            if self.pulou_ultimo_frame and self.tempo_pulo ~= -1 then
                self.vel_y = -10
                self.tempo_pulo = self.tempo_pulo + dt

                if self.tempo_pulo > self.tempo_pulo_max then
                    self.tempo_pulo = -1
                end
            end
        end
    else
        self.pulou_ultimo_frame = false
    end

    --if self.tempo_pulo > self.tempo_pulo_max then
    self.vel_y = self.vel_y + self.gravidade * 15 * dt
    --end
    self.y = self.y + self.vel_y

    self:andar(dt)
    self:ficarNaTela()
end

function Mario:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.l, self.a)
end

function Mario:ficaNoChao(posicao_y_chao)
    self.vel_y = 0
    self.y = posicao_y_chao - self.a
    self.tempo_pulo = 0
    self.esta_no_chao = true
end

function Mario:andar(dt)
    if love.keyboard.isDown("a") then
        self.x = self.x - self.vel_andar * dt
    elseif love.keyboard.isDown("d") then
        self.x = self.x + self.vel_andar * dt
    end
end

function Mario:ficarNaTela()
    if self.x < 0 then
        self.x = 0
    elseif self.x + self.l > 800 then
        self.x = 800 - self.l
    end
end

function Mario:pular(dt)

end
