
require 'pp'

$fishes = `cat 06.txt`.split(",").map{|e| e.to_i }
$cache = { }

def evalFish fish, days

	key = "#{fish} x #{days}"

	return $cache[key] if $cache[key] != nil

	puts "Evaling Fish #{fish} with #{days} days"

	fishes = [fish]

	dayCounter = days

	while dayCounter != 0
		if days != 80 && dayCounter == 80
			return fishes.map{|fish| evalFish fish, 80 }.sum
		else
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
			dayCounter -= 1
		end

	end

	$cache[key] = fishes.count
	fishes.count

end

counts = { }
$fishes.each{|fish|
	counts[fish] = 0 if counts[fish] == nil
	counts[fish] += 1
}

sum = 0

counts.each{|fish,count|
	sum += count * evalFish(fish, 256)
}

puts sum
