
require 'pp'

input = `cat 15.txt`

class String
	def colorize(color_code)
		"\e[#{color_code}m#{self}\e[0m"
	end
	def green
		colorize(32)
	end
end

class Node
	attr_accessor :value, :cost, :parent
	def initialize value
		@value = value
		@cost = nil
		@parent = nil
	end
end

$stack = []

def updateNode map, position, parent, cost
	node = map[position.last][position.first]
	return if node.cost && node.cost <= cost
	node.cost = cost
	node.parent = parent
	$stack << [node, position]
end

def processNode map, node, position
	x, y = position
	updateNode(map, [x + 1, y], [x, y], node.cost + node.value) if map[y][x+1]
	updateNode(map, [x, y + 1], [x, y], node.cost + node.value) if map[y + 1]
	updateNode(map, [x - 1, y], [x, y], node.cost + node.value) if x > 0
	updateNode(map, [x, y - 1], [x, y], node.cost + node.value) if y > 0
end

def printMap map, path = []
	map.each_with_index{|line,y|
		line.each_with_index{|node,x|
			print path.include?([x,y]) ? node.value.to_s.green : node.value.to_s
		}
		puts
	}
	puts
end

map = input.split("\n").map{|line|
	line = line.split('').map{|e| e.to_i }
	line = [[line]] * 5
	line.each_with_index.map{|e,i| e.flatten.map{|n| 
		r = n + i; r -= 9 if r > 9; r 
	} }.flatten
}
linescount = map.count
map = map * 5
map = map.each_with_index.map{|line,i|
	inci = i / linescount
	line.map{|n| r = n + inci; r -= 9 if r > 9; r  }
}

map = map.map{|line| line.map{|num| Node.new num.to_i } }

# printMap map

start = map[0][0]
start.cost = 0

$stack << [start, [0, 0]]

while $stack.count > 0
	node, position = $stack.shift
	processNode map, node, position
end

node = map.flatten.last
path = []

while node.parent
	path << node.parent
	node = map[node.parent.last][node.parent.first]
end

# printMap map, path

all = map.flatten

puts all.last.cost + all.last.value - all.first.value
