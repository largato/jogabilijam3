local Character = require 'character'
local steer = require 'steer'

Officer = Character:extend()

-- States
local STATE_IDLE = 'idle'
local STATE_MOVING = 'moving'
local STATE_LOADING = 'loading'
local STATE_ATTACKING = 'attacking'
local STATE_DEAD = 'dead'

local LOAD_FRAMES = 20
local ATTACK_FRAMES = 40

function Officer:new(x, y, life, damage, loyalty)
   Officer.super.new(self, x, y, life, damage, loyalty)
   self.state = STATE_IDLE
   self.target = nil
   self.box_height = 32
   self.box_width = 32

   -- Motion
   self.velocity = vector(0, 0)
   self.max_velocity = 1.0

   -- Distances
   self.sight_distance = 2000
   self.attack_distance = 20

   -- Timers
   self.loading_timer = 0
   self.attacking_timer = 0

   -- sprite
   self.sprite = sodapop.newAnimatedSprite(x, y)

   self.sprite:addAnimation(STATE_IDLE,
       { image = love.graphics.newImage 'assets/images/officer-spritesheet.png',
         frameWidth=32, frameHeight=32, stopAtEnd=false, frames={ {1, 1, 7, 1, .1} } })

   self.sprite:addAnimation(STATE_MOVING,
       { image = love.graphics.newImage 'assets/images/officer-spritesheet.png',
         frameWidth=32, frameHeight=32, stopAtEnd=false, frames={ {1, 3, 7, 3, .1} } })

   self.sprite:addAnimation(STATE_LOADING,
       { image = love.graphics.newImage 'assets/images/officer-spritesheet.png',
         frameWidth=32, frameHeight=32, stopAtEnd=false, frames={ {1, 7, 7, 7, .1} } })

   self.sprite:addAnimation(STATE_ATTACKING,
       { image = love.graphics.newImage 'assets/images/officer-spritesheet.png',
         frameWidth=32, frameHeight=32, stopAtEnd=false, frames={ {1, 9, 7, 9, .1} } })

   self.sprite:addAnimation(STATE_DEAD,
       { image = love.graphics.newImage 'assets/images/officer-spritesheet.png',
         frameWidth=32, frameHeight=32, stopAtEnd=true, frames={ {1, 17, 7, 17, .2} } })
end

function Officer:update(dt)
   Officer.super.update(self, dt)
   if self.state == STATE_IDLE then
      self:look()
   elseif self.state == STATE_MOVING then
      self:move()
   elseif self.state == STATE_LOADING then
      self:load()
   elseif self.state == STATE_ATTACKING then
      self:attack()
   end
end

function Officer:receiveDamage(damage)
   self.life = math.max(0, self.life - damage)
   if self:isDead() then
      self:changeState(STATE_DEAD)
   end
end

function Officer:look()
   self:seek_target()
   if not (self.target == nil) then
      self:changeState(STATE_MOVING)
      self.sprite.flipX = self.target.position.x < self.position.x
   end
end

function Officer:move()
   self:seek_target()
   if not (self.target==nil) then
      local distance = self.position:dist(self.target.position)
      if distance > self.attack_distance then
         local desired_velocity = steer.seek(self.position, self.target.position) * self.max_velocity
         local steering = desired_velocity - self.velocity
         self.velocity = self.velocity + steering
         self.position = self.position + self.velocity

         local polar = self.velocity:toPolar()
         if (polar[1] ~= nil) then
            self.sprite.flipX = math.cos(polar[1]) >= 0
         end
      else
         self:changeState(STATE_LOADING)
      end
   end
end

function Officer:load()
   if self.loading_timer >= LOAD_FRAMES then
      self.loading_timer = 0
      self:changeState(STATE_ATTACKING)
   else
      self.loading_timer = self.loading_timer + 1
   end
end

function Officer:attack()
   if self.attacking_timer >= ATTACK_FRAMES then
      self.attacking_timer = 0
      self.target:receiveDamage(self.damage)
      self:changeState(STATE_IDLE)
      soundManager:play("melee")
   else
      self.attacking_timer = self.attacking_timer + 1
   end
end

function Officer:seek_target()
   self.target = nil
   local closer = self.sight_distance
   for i, dem in ipairs(gameworld_demonstrators) do
      local distance = self.position:dist(dem.position)
      if distance < closer and (not dem:isDead()) then
         closer = distance
         self.target = dem
         print("Target found!" .. distance)
      end
   end
end


return Officer
