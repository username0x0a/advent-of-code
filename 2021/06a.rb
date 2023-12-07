
require 'pp'

days = 80
fishes = `cat 06.txt`.split(",").map{|e| e.to_i }

while days != 0
	newones = []
	fishes.map!{|fish|
		case fish
		when 0
			newones << 8
			6
		else
			fish - 1
		end
	}
	fishes << newones
	fishes.flatten!
	days -= 1

end

puts fishes.count
puts fishes.join ","
