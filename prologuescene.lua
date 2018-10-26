local Timer = require 'libs/knife/knife/timer'

PrologueScene = Scene:extend()

function PrologueScene:new()
end

function PrologueScene:init()
   -- Fonts
   self.title_font = assets.fonts.hemi_head_bd_it(36)
   self.text_font = assets.fonts.hemi_head_bd_it(36)

   self.drawFunction = nil
   self:startTimers()
end

function PrologueScene:update(dt)
   Timer.update(dt)
end

function PrologueScene:draw()
   if not (self.drawFunction == nil) then
      self:drawFunction()
   end
end

function PrologueScene:startTimers()
   Timer.after(1, function() self.drawFunction = self.hideo end)
   Timer.after(1, function() soundManager:play("thunder") end)

   Timer.after(2, function() soundManager:play("rain") end)

   Timer.after(4, function() self.drawFunction = self.not_hideo end)

   Timer.after(7, function() self.drawFunction = self.place end)
   Timer.after(9, function() self.drawFunction = self.place_and_time end)


   Timer.after(12, function() self.drawFunction = self.history_1 end)
   Timer.after(17, function() self.drawFunction = self.history_2 end)
   Timer.after(22, function() self.drawFunction = self.history_3 end)

   Timer.after(30, function() self.drawFunction = self.blank end)

   Timer.after(33, function() self.drawFunction = self.history_4 end)
   Timer.after(38, function() self.drawFunction = self.history_5 end)
   Timer.after(43, function() self.drawFunction = self.history_6 end)
   Timer.after(43, function() soundManager:play("thunder") end)

   Timer.after(48, function() self:endScene() end)
end

function PrologueScene:hideo()
   love.graphics.setFont(self.title_font)
   love.graphics.setColor(255, 255, 255)
   love.graphics.print("A HIDEO KOJIMA GAME", 1400, 800)
end

function PrologueScene:not_hideo()
   love.graphics.setFont(self.title_font)
   love.graphics.setColor(255, 255, 255)
   love.graphics.print("NOT", 1320, 800)
   love.graphics.print("A HIDEO KOJIMA GAME", 1400, 800)
end

function PrologueScene:place()
   local text = "SÃO PAULO, BRASIL DO SUL"
   local text_width = love.graphics.getFont():getWidth(text)
   love.graphics.setFont(self.title_font)
   love.graphics.setColor(255, 255, 255)
   love.graphics.print(text,
                       (CONF_SCREEN_WIDTH - text_width)/2,
                       CONF_SCREEN_HEIGHT/2)
end

function PrologueScene:place_and_time()
   self:place()
   local text = "1 DE MAIO, 2077"
   local text_width = love.graphics.getFont():getWidth(text)
   love.graphics.setColor(255, 0, 0)
   love.graphics.print(text,
                       (CONF_SCREEN_WIDTH - text_width)/2,
                       (CONF_SCREEN_HEIGHT/2) + 45)
end

function PrologueScene:history_1()
   love.graphics.setFont(self.text_font)
   love.graphics.setColor(1, 1, 1)
   local text = "Após 16 anos de guerra de separação contra seus ex-compatriotas do norte,\no Brasil do Sul padece de graves problemas sociais."
   love.graphics.print(text, 100, 200)
end

function PrologueScene:history_2()
   self:history_1()
   local text = "Com o decréscimo populacional, perda de mão-de-obra e\nmercado consumidor, o país enfrenta uma crise jamais vista."
   love.graphics.print(text, 250, 400)
end

function PrologueScene:history_3()
   self:history_2()
   local text = {
      {1,1,1}, "Buscando mão-de-obra barata, o presidente ",
      {0,1,0}, "Enzo ",
      {1,1,0}, "Bilnosliro",
      {1,1,1}, ",\nneto do Duque, organiza minorias em campos de trabalho.\n\nÉ a SOLUÇÃO FINAL."
   }
   love.graphics.print(text, 400, 600)
end

function PrologueScene:blank()
end

function PrologueScene:history_4()
   love.graphics.setFont(self.text_font)
   love.graphics.setColor(1, 1, 1)
   local text = {
      {1,1,1}, "Com apoio clandestino da ",
      {1,0,0}, "URSENE",
      {1, 1, 1}, ", o quilombo Casa Verde\né um dos últimos focos de resistência."
   }
   love.graphics.print(text, 100, 300)
end

function PrologueScene:history_5()
   self:history_4()
   local text = "Após meses de guerrilha urbana, as autoridades \ntentam esmagar os rebeldes de uma vez por todas."
   love.graphics.print(text, 250, 550)
end

function PrologueScene:history_6()
   local text = "Hoje acontece o levante derradeiro."
   local text_width = love.graphics.getFont():getWidth(text)
   love.graphics.setFont(self.title_font)
   love.graphics.setColor(255, 255, 255)
   love.graphics.print(text,
                       (CONF_SCREEN_WIDTH - text_width)/2,
                       CONF_SCREEN_HEIGHT/2)
end

function PrologueScene:endScene()
   sceneManager:setCurrent('game')
end

function PrologueScene:keyPressed(key, scancode, isRepeat)
end

function PrologueScene:keyReleased(key, scancode, isRepeat)
end

function PrologueScene:mousepressed(x, y, button, istouch, presses)
end

function PrologueScene:mousereleased(x, y, button, istouch, presses)
end

function PrologueScene:mousemoved(x, y, dx, dy, istouch)
end

function PrologueScene:wheelmoved(dx, dy)
end

function PrologueScene:gamepadpressed(joystick, button)
end

function PrologueScene:gamepadreleased(joystick, button)
end

function PrologueScene:gamepadaxis(joystick, axis, value)
end

return PrologueScene
