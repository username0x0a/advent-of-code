
require 'pp'

class String
	def colorize(color_code)
		"\e[#{color_code}m#{self}\e[0m"
	end

	def red
		colorize(31)
	end

	def green
		colorize(32)
	end

	def yellow
		colorize(33)
	end
end

$map = `cat 09.txt`.split("\n").map{|line| line.split('').map{|e| e.to_i } }

mins = []

$map.each_with_index{|curline,y|
	prevline = y-1 >= 0 ? $map[y-1] : nil
	nextline = $map[y+1]
	curline.each_with_index{|e,x|
		smallest = true
		smallest = false if x > 0 && curline[x-1] <= e
		smallest = false if curline[x+1] && curline[x+1] <= e
		smallest = false if prevline && prevline[x] <= e
		smallest = false if nextline && nextline[x] <= e
		mins << [x,y] if smallest
		# print smallest ? $map[y][x] : '*'
	}
	# puts
}
# puts

puts "#{mins.count} mins found"

basins = []

mins.each{|(x,y)|

	$cache = {}

	def ckey x, y
		"#{x}x#{y}"
	end

	def process x, y, val

		key = ckey x, y
		# puts key + ' ' + val.to_s
		return if $cache[key] != nil
		$cache[key] = $map[y][x]

		around = []
		around << [x-1, y] if x > 0
		around << [x+1, y] if $map[y][x+1]
		around << [x, y-1] if y > 0
		around << [x, y+1] if $map[y+1]

		around.each{|(ax, ay)|
			aval = $map[ay][ax]
			# process ax, ay, aval if aval == val+1 && aval != 9 // by +1 steps, invalid, not obvious
			process ax, ay, aval if aval > val && aval != 9
		}

	end

	process x, y, $map[y][x]

	basins << $cache.values.count

	$map.each_with_index{|line,y|
		line.each_with_index{|e,x|
			key = ckey x, y
			val = $map[y][x].to_s
			print $cache[key] != nil ? val.red : val
		}
		puts
	}
	puts

}

puts "Max basins multiple: " + basins.sort[-3..].reduce(&:*).to_s
