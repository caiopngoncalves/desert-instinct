Mario = Classe:extend()


function Mario:new()
    self.sprites = {}
    self.bucketSprite = love.graphics.newImage("barrel.png")
    self.currentSprite = 0
    for i = 0, 6 do
        self.sprites[i] = love.graphics.newImage(i .. ".png")
    end
    self.x, self.y = 30, 30
    self.l, self.a = self.sprites[self.currentSprite]:getWidth() * 0.03,
        self.sprites[self.currentSprite]:getHeight() * 0.03
    self.gravidade = 2
    self.vel_pulo = 5
    self.vel_y = 0
    self.vel_andar = 500
    self.tempo_pulo = 0
    self.tempo_pulo_max = 0
    self.esta_no_chao = false
    self.pulou_ultimo_frame = false
    self.toRight = true
    self.currentTimer = 0
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
    self.vel_y = self.vel_y + self.gravidade * 0.1
    --end
    self.y = self.y + self.vel_y

    self:andar(dt)
    self:ficarNaTela()
end

function Mario:draw()
    if self.toRight then
        love.graphics.draw(self.sprites[self.currentSprite], self.x + self.l, self.y, 0, -0.03, 0.03)
        love.graphics.draw(self.bucketSprite, self.x - 5,
            self.y - self.bucketSprite:getHeight())
    else
        love.graphics.draw(self.sprites[self.currentSprite], self.x, self.y, 0, 0.03, 0.03)
        love.graphics.draw(self.bucketSprite, self.x + 5,
            self.y - self.bucketSprite:getHeight())
    end
end

function Mario:ficaNoChao(posicao_y_chao)
    self.vel_y = 0
    self.y = posicao_y_chao - self.a
    self.tempo_pulo = 0
    self.esta_no_chao = true
end

function Mario:andar(dt)
    local changeInterval = 0.2
    if love.keyboard.isDown("a") then
        self.currentTimer = self.currentTimer + dt

        if self.currentTimer > changeInterval then
            self.currentSprite = self.currentSprite + 1
            if self.currentSprite > 6 then
                self.currentSprite = 1
            end
            self.currentTimer = 0
        end


        self.toRight = true
        self.l = math.abs(self.l)
        self.x = self.x - self.vel_andar * dt
    elseif love.keyboard.isDown("d") then
        self.currentTimer = self.currentTimer + dt

        if self.currentTimer > changeInterval then
            self.currentSprite = self.currentSprite + 1
            if self.currentSprite > 6 then
                self.currentSprite = 1
            end
            self.currentTimer = 0
        end
        self.toRight = false
        self.l = self.l
        self.x = self.x + self.vel_andar * dt
    else
        self.currentSprite = 0
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
