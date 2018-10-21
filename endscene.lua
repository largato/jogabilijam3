local Timer = require 'libs/knife/knife/timer'

EndScene = Scene:extend()

function EndScene:new()
end

function EndScene:init()
   -- Fonts
   self.title_font = assets.fonts.hemi_head_bd_it(40)
   self.img_antifa = love.graphics.newImage('assets/images/antifa.png')

   self.drawFunction = nil
   self:startTimers()

   soundManager:stopAll()
end

function EndScene:update(dt)
   Timer.update(dt)
end

function EndScene:draw()
   if not (self.drawFunction == nil) then
      self:drawFunction()
   end
end

function EndScene:startTimers()
   Timer.after(0.1, function() soundManager:play("rain") end)
   Timer.after(1, function() self.drawFunction = self.maiakovski end)
   
   Timer.after(15, function() soundManager:play("thunder") end)
   Timer.after(15, function() self.drawFunction = self.antifa end)

   Timer.after(20, function() self.drawFunction = self.thank end)

   Timer.after(25, function() self:endScene() end)
end

function EndScene:maiakovski()
   local text = "\"... Não estamos alegres, é certo,\nmas também por que razão\nhaveríamos de ficar tristes?\nO mar da história é agitado.\nAs ameaças e as guerras\nhavemos de atravessá-las,\nrompê-las ao meio, cortando-as,\ncomo uma quilha corta as ondas\"\n\n-Vladimir Maiakovski"
   love.graphics.setFont(self.title_font)
   love.graphics.setColor(255, 255, 255)
   love.graphics.print(text, 550, 300)
end

function EndScene:thank()
   local text = "OBRIGADO POR JOGAR"
   local text_width = love.graphics.getFont():getWidth(text)
   love.graphics.setFont(self.title_font)
   love.graphics.setColor(255, 255, 255)
   love.graphics.print(text,
                       (CONF_SCREEN_WIDTH - text_width)/2,
                       CONF_SCREEN_HEIGHT/2)
end

function EndScene:antifa()
   local text = "Uma homenagem à"
   local text_width = love.graphics.getFont():getWidth(text)
   love.graphics.setFont(self.title_font)
   love.graphics.setColor(255, 255, 255)
   love.graphics.print(text,
                       (CONF_SCREEN_WIDTH - text_width)/2,
                       100)
   love.graphics.draw(self.img_antifa,
                      (CONF_SCREEN_WIDTH-self.img_antifa:getWidth())/2,
                      150)
end

function EndScene:endScene()
   sceneManager:setCurrent('menu')
end

return EndScene
