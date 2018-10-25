EventManager = Object:extend()

local Timer = require 'libs/knife/knife/timer'

function EventManager:new(eventScript)
   self.eventScript = eventScript
end

function EventManager:init()
   self:deploy();
   Timer.every(60, function() self:deploy() end)
end

function EventManager:deploy()
   for i, event in ipairs(self.eventScript) do
      Timer.after(event.time,
         function()
            local unit = event.unit(event.x, event.y, event.life, event.damage, Character.LOYALTY_ENEMY)
            local overlap = false

            for j, officer in ipairs(gameworld_officers) do
               local u = vector(unit.bbox.x, unit.bbox.y)
               local o = vector(officer.bbox.x, officer.bbox.y)
               local d = u:dist(o)
               overlap = d < unit.bbox.w

               if overlap then
                  break
               end
            end

            if not overlap then
              table.insert(gameworld_officers, unit)
            else
              print('skip spawn enemy because overlap')
            end
         end)
   end
end

function EventManager:update(dt)
    Timer.update(dt)
end

return EventManager
