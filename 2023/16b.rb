#!/usr/bin/env ruby

class Array
	def oob x, y
		x < 0 || y < 0 || x >= self.size || y >= self.size
	end

	def anext x, y, direction
		case direction
		when :left   then return x-1, y
		when :right  then return x+1, y
		when :up     then return x, y-1
		when :down   then return x, y+1
		end
	end

	def follow x, y, direction, path
		key = "#{x},#{y} #{direction}"
		return if path[key] || oob(x,y)
		path[key] = 1
		at = self[y][x]
		case at
		when '.'
			nx, ny = anext x, y, direction
			follow nx, ny, direction, path
		when '|'
			if [:up, :down].include? direction
				nx, ny = anext x, y, direction
				follow nx, ny, direction, path
			else
				nx, ny = anext x, y, :up
				follow nx, ny, :up, path
				nx, ny = anext x, y, :down
				follow nx, ny, :down, path
			end
		when '-'
			if [:left, :right].include? direction
				nx, ny = anext x, y, direction
				follow nx, ny, direction, path
			else
				nx, ny = anext x, y, :left
				follow nx, ny, :left, path
				nx, ny = anext x, y, :right
				follow nx, ny, :right, path
			end
		when '/'
			case direction
			when :up
				nx, ny = anext x, y, :right
				follow nx, ny, :right, path
			when :down
				nx, ny = anext x, y, :left
				follow nx, ny, :left, path
			when :left
				nx, ny = anext x, y, :down
				follow nx, ny, :down, path
			when :right
				nx, ny = anext x, y, :up
				follow nx, ny, :up, path
			end
		when '\\'
			case direction
			when :up
				nx, ny = anext x, y, :left
				follow nx, ny, :left, path
			when :down
				nx, ny = anext x, y, :right
				follow nx, ny, :right, path
			when :left
				nx, ny = anext x, y, :up
				follow nx, ny, :up, path
			when :right
				nx, ny = anext x, y, :down
				follow nx, ny, :down, path
			end
		end
	end
end

input = File.read '16.txt'
map = input.split("\n").map{|line| line.split('') }

def sum map, x, y, direcion
	path = {}
	map.follow x, y, direcion, path
	path.keys.map{|key| key.split(' ').first }.uniq.size
end

puts 0.upto(input.size-1).each.map{|idx|
	up    = sum map, idx, input.size-1, :up
	down  = sum map, idx, 0, :down
	left  = sum map, input.size-1, idx, :left
	right = sum map, 0, idx, :right
	[up, down, left, right].max
}.max
