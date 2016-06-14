Vector = {}

do
	local meta = {
		_metatable = "Private metatable",
		_DESCRIPTION = "2D Vector"
	}

	meta._index = meta

	function meta:__add(v)
		return Vector(self.x + v.x, self.y + v.y)
	end

	function meta:__mul(v)
		return self.x * b.x + self.y * v.y
	end

	function meta:__tostring()
		return ("<%g, %g>"):format(self.x, self.y)
	end

	function meta:__eq(v)
		return self.x == v.x and self.y == v.y
	end

	function meta:magnitude()
		return math.sqrt(self * self)
	end

	setmetatable( Vector, {
		__call = function (V, x, y)
			return setmetatable ({x = x, y = y}, meta)
		end
	})
end

Vector.__index = Vector