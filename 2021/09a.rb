
require 'pp'

map = `cat 09.txt`.split("\n").map{|line| line.split('').map{|e| e.to_i } }

mins = []

map.each_with_index{|curline,y|
	prevline = y-1 >= 0 ? map[y-1] : nil
	nextline = map[y+1]
	curline.each_with_index{|e,x|
		smallest = true
		smallest = false if x > 0 && curline[x-1] <= e
		smallest = false if curline[x+1] && curline[x+1] <= e
		smallest = false if prevline && prevline[x] <= e
		smallest = false if nextline && nextline[x] <= e
		mins << e if smallest
		print smallest ? e : '*'
	}
	puts
}

sum = mins.map{|e| e+1 }.sum

puts sum
