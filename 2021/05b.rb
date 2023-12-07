
require 'pp'

input = `cat 05.txt`.split "\n"

map = { }

input.each{|line|

	vals = line.split ' -> '
	# pp vals
	x1, y1 = vals.first.split(',').map{|e| e.to_i }
	x2, y2 = vals.last.split(',').map{|e| e.to_i }

	# next if x1 != x2 && y1 != y2

	xdiff = x2-x1
	ydiff = y2-y1
	steps = [xdiff.abs, ydiff.abs].max

	# pp x1, y1, x2, y2
	# puts

	throw :uglyValue if xdiff != 0 && ydiff != 0 && xdiff.abs != ydiff.abs

	0.upto(steps).each{|step|
		xidx = x1 + step * (xdiff > 0 ? 1 : xdiff < 0 ? -1 : 0)
		yidx = y1 + step * (ydiff > 0 ? 1 : ydiff < 0 ? -1 : 0)
		key = "#{xidx},#{yidx}"
		map[key] = 0 if map[key] == nil
		map[key] += 1
	}

}

puts map.select{|k,v| v >= 2 }.count
