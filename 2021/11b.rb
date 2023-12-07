
require 'pp'

class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end
  def red
    colorize(31)
  end
end

map = `cat 11.txt`.split("\n").map{|line| line.split('').map{|e| e.to_i } }

1.upto(100_000_000){|step|

	idxs = []

	map.each_with_index {|line,y|
		line.each_with_index{|puss,x|
			map[y][x] += 1
			idxs << [x,y] if map[y][x] >= 10
		}
	}

	while true
		idx = idxs.shift
		break if idx == nil
		(x, y) = idx
		if x > 0 && y > 0;                          map[y-1][x-1] += 1; idxs << [x-1,y-1] if map[y-1][x-1] == 10; end
		if y > 0;                                   map[y-1][x]   += 1; idxs << [x,y-1]   if map[y-1][x] == 10;   end
		if y > 0 && x < map[y-1].count-1;           map[y-1][x+1] += 1; idxs << [x+1,y-1] if map[y-1][x+1] == 10; end
		if x > 0;                                   map[y][x-1]   += 1; idxs << [x-1,y]   if map[y][x-1] == 10;   end
		if x < map[y].count-1;                      map[y][x+1]   += 1; idxs << [x+1,y]   if map[y][x+1] == 10;   end
		if y < map.count-1 && x > 0;                map[y+1][x-1] += 1; idxs << [x-1,y+1] if map[y+1][x-1] == 10; end
		if y < map.count-1;                         map[y+1][x]   += 1; idxs << [x,y+1]   if map[y+1][x] == 10;   end
		if y < map.count-1 && x < map[y+1].count-1; map[y+1][x+1] += 1; idxs << [x+1,y+1] if map[y+1][x+1] == 10; end
	end

	map.each_with_index {|line,y|
		line.each_with_index{|puss,x|
			if puss >= 10
				map[y][x] = 0
			end
		}
	}

	puts "Step #{step}:"
	puts map.map{|e|e.map{|e|e == 0 ? e.to_s.red : e.to_s}.join}.join"\n"
	puts

	break if map.flatten.uniq == [0]

}
