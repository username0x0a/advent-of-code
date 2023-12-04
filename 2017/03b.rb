#!/usr/bin/env ruby

MAX  = 289326
SIZE = ((Math.sqrt(MAX).ceil/2).ceil * 2 + 1) + 2

directions = {
	:right => :up, 
	:up    => :left, 
	:left  => :down, 
	:down  => :right,
}

class Array
	def pp
		puts self.map{|e| e.map{|v| "%02d" % v }.join(" ") }
	end

	def set x, y, value
		self[y + SIZE/2][x + SIZE/2] = value
	end

	def at x, y, direction = nil
		x, y = adjust(x, y, direction) if direction != nil
		self[y + SIZE/2][x + SIZE/2]
	end

	def sum_around x, y
		sum = 0
		((x-1)..(x+1)).each{|ax|
			((y-1)..(y+1)).each{|ay|
				an = self.at ax, ay
				sum += an if an != nil
			}
		}
		sum
	end

	def adjust x, y, direction
		case direction
		when :up    then return x, y-1
		when :down  then return x, y+1
		when :left  then return x-1, y
		when :right then return x+1, y
		end
	end
end

line = (1..SIZE).map{|i| 0 }
map  = (1..SIZE).map{|i| line.dup }

state = {:direction => :down, :x => 0, :y => 0}

while true
	x, y = state[:x], state[:y]
	new_value = [1, map.sum_around(x, y)].max
	if new_value > MAX
		puts new_value
		break
	end
	map.set(x, y, new_value)
	new_direction = directions[state[:direction]]
	cx, cy = map.adjust x, y, new_direction
	if map.at(cx,cy) == 0
		state[:direction] = new_direction
	else
		cx, cy = map.adjust x, y, state[:direction]
	end
	state[:x] = cx
	state[:y] = cy
end

map.pp
