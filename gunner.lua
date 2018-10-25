local Character = require 'character'
local steer = require 'steer'

Gunner = Character:extend()

local LOAD_FRAMES = 20
local ATTACK_FRAMES = 40

function Gunner:new(x, y, life, damage, loyalty)
   Gunner.super.new(self, x, y, life, damage, loyalty)
   self.state = STATE_IDLE
   self.target = nil

   -- Motion
   self.velocity = vector(0, 0)
   self.max_velocity = 0.8

   -- Distances
   self.sight_distance = 1000
   self.attack_distance = 370

   -- Timers
   self.loading_timer = 0
   self.attacking_timer = 0

   -- sprite
   self.sprite = sodapop.newAnimatedSprite(x, y)
   self.sprite.flipX = self.loyalty == self.LOYALTY_USER

   local spritesheet = "assets/images/enemy_gunner.png"

   if self.loyalty==self.LOYALTY_USER then
      spritesheet = "assets/images/player_gunner.png"
   end

   self.sprite:addAnimation(STATE_IDLE,
       { image = love.graphics.newImage(spritesheet),
         frameWidth=120, frameHeight=120, stopAtEnd=false, frames={ {1, 1, 4, 1, .2} } })

   self.sprite:addAnimation(STATE_MOVING,
       { image = love.graphics.newImage(spritesheet),
         frameWidth=120, frameHeight=120, stopAtEnd=false, frames={ {1, 4, 4, 4, .2} } })

   self.sprite:addAnimation(STATE_LOADING,
       { image = love.graphics.newImage(spritesheet),
         frameWidth=120, frameHeight=120, stopAtEnd=false, frames={ {1, 1, 4, 1, .2} } })

   self.sprite:addAnimation(STATE_ATTACKING,
       { image = love.graphics.newImage(spritesheet),
         frameWidth=120, frameHeight=120, stopAtEnd=false, frames={ {1, 3, 4, 3, .2} } })

   self.sprite:addAnimation(STATE_DEAD,
       { image = love.graphics.newImage(spritesheet),
         frameWidth=120, frameHeight=120, stopAtEnd=true, frames={ {1, 2, 4, 2, .2} } })
end

function Gunner:update(dt)
   Gunner.super.update(self, dt)

   if self.state == STATE_IDLE then
      self:look()
   elseif self.state == STATE_MOVING then
      self:move()
   elseif self.state == STATE_LOADING then
      self:load()
   elseif self.state == STATE_ATTACKING then
      self:attack()
   elseif self.state == STATE_DEAD then
      self.dead_for = self.dead_for + dt
   end

   self:clamp()
end

function Gunner:look()
   self:seek_target()
   if not (self.target == nil) then
      self:changeState(STATE_MOVING)
      self.sprite.flipX = self.target.position.x < self.position.x
   end
end

function Gunner:load()
   if self.loading_timer >= LOAD_FRAMES then
      self.loading_timer = 0
      self:changeState(STATE_ATTACKING)
   else
      self.loading_timer = self.loading_timer + 1
   end
end

function Gunner:attack()
   self:seek_target()
   if self.target~=nil and self.attacking_timer >= ATTACK_FRAMES then
      self.attacking_timer = 0
      self:shoot()
      self.target:receiveDamage(self.damage)
      self:changeState(STATE_IDLE)
      soundManager:playSfx("laser")
   else
      self.attacking_timer = self.attacking_timer + 1
   end
end

function Gunner:shoot()
   table.insert(gameworld_projectiles,
                Projectile(8,
                           self.position.x,
                           self.position.y,
                           self.target.position.x,
                           self.target.position.y,
                           0.2,
                           self.loyalty))
end

function Gunner:seek_target()
   self.target = nil
   local closer = self.sight_distance
   for i, dem in ipairs(self:getEnemiesList()) do
      local distance = self.position:dist(dem.position)
      if distance < closer and (not dem:isDead()) then
         closer = distance
         self.target = dem
         print("Target found!" .. distance)
      end
   end
end


return Gunner
