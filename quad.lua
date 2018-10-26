Quad = Object:extend()

function Quad:new(center_x, center_y, width, height)
   self.x = center_x
   self.y = center_y
   self.w = width
   self.h = height
end

function Quad:collide(other)
   return math.abs(self.x - other.x) < (math.abs(self.w + other.w)/2) and
   math.abs(self.y - other.y) < (math.abs(self.h + other.h)/2)
end

return Quad
