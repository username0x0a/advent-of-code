
require 'pp'

input = `cat 13.txt`
points, folding = input.split "\n\n"

points = points.split("\n").map{|line| line.split(',').map{|e|e.to_i} }

def foldPoints points, xFold, yFold
	# puts "#{points} x:#{xFold} y:#{yFold}"
	points.map{|point|
		x, y = point.first, point.last
		if xFold != nil && xFold < x
			x = (xFold - (x-xFold)).abs
		elsif yFold != nil && yFold < y
			y = (yFold - (y-yFold)).abs
		end
		[x, y]
	}
end

def printPoints points
	map = []
	width = points.reduce(0){|maxX, point| [maxX, point.first].max }
	points.each{|point|
		x, y = point.first, point.last
		map[y] = [] if map[y] == nil
		map[y][x] = 1
	}
	puts map.map{|line| 
		line = line ? line.map{|e| e ? '#':'.'}.join : ''
		line = line + '.'*(width-line.length+1) if line.length <= width
		line
	}.join"\n"
	puts

end

# printPoints points

folding = folding.split"\n"

folding.each{|fold_|
	fold = fold_.sub 'fold along ', ''
	x = nil; y = nil
	var, val = fold.split'='
	x = val.to_i if var == 'x'
	y = val.to_i if var == 'y'
	points = foldPoints points, x, y
	printPoints points if fold_ == folding.last
	puts points.uniq.count if fold_ == folding.first
}


