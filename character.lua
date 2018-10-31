require "assets"

local steer = require 'steer'

Character = Object:extend()

Character.LOYALTY_NONE  = "none"
Character.LOYALTY_USER  = "user"
Character.LOYALTY_ENEMY = "enemy"
Character.LOYALTY_ALLY  = "ally"

Character.VANISH_TIME = 3
Character.MAX_FRAMES_STUCK = 5

STATE_IDLE = 'idle'
STATE_MOVING = 'moving'
STATE_LOADING = 'loading'
STATE_ATTACKING = 'attacking'
STATE_DEAD = 'dead'

function Character:new(x, y, life, damage, loyalty)
   self.position = vector(x, y)
   self.life = life
   self.max_life = life
   self.damage = damage
   self.loyalty = loyalty
   self.bbox = Quad(x, y, 120, 30)
   self.dead_for = 0
   self.frames_stuck = 0
end

function Character:isDead()
   return self.life <= 0
end

function Character:isGone()
   return self.dead_for >= self.VANISH_TIME
end

function Character:receiveDamage(damage)
   self.life = math.max(0, self.life - damage)
   if self:isDead() then
      self:changeState(STATE_DEAD)
   end
end

function Character:isHurt()
   return self.life < self.max_life
end

function Character:isHealable()
   return true
end

function Character:clamp()
    self.position.x = math.Clamp(self.position.x, self.bbox.w/2, CONF_SCREEN_WIDTH - self.bbox.w/2)
    self.position.y = math.Clamp(self.position.y, self.bbox.h/2, CONF_SCREEN_HEIGHT - self.bbox.h/2)
end


function Character:changeState(state)
   if self.sprite.animations[state] ~= nil then
      self.sprite:switch(state)
   end
   self.state = state

   if self.state == STATE_DEAD then
       if self.loyalty == Character.LOYALTY_ENEMY then
           gameworld_enemy_deaths = gameworld_enemy_deaths + 1
       else
           gameworld_player_deaths = gameworld_player_deaths + 1
       end
   end
end

function Character:update(dt)
   if self.sprite == nil then
      return
   end

   self.sprite.x = self.position.x
   self.sprite.y = self.position.y

   self.bbox.x = self.position.x - (self.bbox.w/2)
   self.bbox.y = self.position.y + (self.bbox.h)

   local polar = self.velocity:toPolar()
   if (polar.y ~= 0) then
      self.sprite.flipX = math.sin(polar.x) < 0
   end
   self.sprite:update(dt)
end

function Character:draw(ox, oy)
   if self.sprite == nil then
      return
   end
   self.sprite:draw(ox, oy)

   -- Draw life bar
   if not self:isDead() then
      love.graphics.setColor(0, 0, 0)
      love.graphics.rectangle("fill", self.bbox.x, self.position.y - (self.bbox.h*2), self.bbox.w, 5)
      love.graphics.setColor(0, 255, 0)
      love.graphics.rectangle("fill", self.bbox.x, self.position.y - (self.bbox.h*2), self.bbox.w * (self.life/self.max_life), 5)
   end

   -- Draw bounding box
   -- if not self:isDead() then
      -- love.graphics.setColor(1,0,0,0.5)
      -- love.graphics.rectangle("fill", self.bbox.x, self.bbox.y, self.bbox.w, self.bbox.h)
   -- end
end

function Character:move()
   self:seek_target()
   if not (self.target==nil) then
      local distance = self.position:dist(self.target.position)
      if distance > self.attack_distance then
         local desired_velocity = steer.seek(self.position, self.target.position) * self.max_velocity
         local steering = desired_velocity - self.velocity
         self.velocity = self.velocity + steering

         local new_position = self.position + self.velocity

         local friends_list = self:getFriendsList()
         for i, friend in ipairs(friends_list) do
            if self ~= friend and self.bbox:collide(friend.bbox) then
               self.frames_stuck = self.frames_stuck + 1
               if self.frames_stuck < Character.MAX_FRAMES_STUCK then
                  return
               end
            end
         end
         self.position = new_position
         self.frames_stuck = 0
      else
         self:changeState(STATE_LOADING)
      end
   end
end

function Character:getEnemiesList()
   if self.loyalty == self.LOYALTY_USER then
      return gameworld_officers
   elseif self.loyalty == self.LOYALTY_ENEMY then
      return gameworld_demonstrators
   end
end

function Character:getFriendsList()
   if self.loyalty == self.LOYALTY_USER then
      return gameworld_demonstrators
   elseif self.loyalty == self.LOYALTY_ENEMY then
      return gameworld_officers
   end

end

return Character
