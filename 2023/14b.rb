#!/usr/bin/env ruby

# 104268 too low
# 104278 too low
# 104325 too low
# 104409

require 'digest/md5'

input = File.read '14.txt'
# input = <<EOF
# O....#....
# O.OO#....#
# .....##...
# OO.#O....O
# .O.....O#.
# O.#..O.#.#
# ..O..#O..O
# .......O..
# #....###..
# #OO..#....
# EOF

input = input.split "\n"

def print map
	puts
	puts map.join "\n"
	puts
end

def sum map
	map.each_with_index.map{|line,y|
		line.count('O') * (map.size - y)
	}.reduce(:+)
end

def tilt map, direction

	width = map.first.length
	flip = [:west, :east].include? direction
	xshift = direction == :south ? +0 : 0
	yshift = direction == :east ? +0 : 0

	0.upto(width-1).each{|sx|
		spacebuf = []
		0.upto(width-1).each{|sy|
			x = sx; y = sy
			# pp spacebuf
			case direction
			when :south then y=width-1-y
			when :west  then y,x = x,y
			when :east  then y=width-1-y; y,x = x,y
			end
			# puts "#{x},#{y}: #{map[y][x]}"
			case map[y][x]
			when 'O'
				if sp = spacebuf.shift
					map[sp[1]][sp[0]] = 'O'
					map[y][x] = '.'
					spacebuf << [x,y]
				else
					spacebuf = []
				end
			when '.'
				spacebuf << [x,y]
			when '#'
				spacebuf = []
			end
		}
	}
end

# print input

cache = {}
i = 1
repeats = 1_000_000_000

while true

	break if i > repeats

	key = Digest::MD5.hexdigest(input.join(','))[0...10]

	if cache[key] != nil
		puts "cache hit: #{i} @ #{key} vs #{cache[key][:i]}"
		input = cache[key][:map].split(',')
		step = i - cache[key][:i]
		pi = (repeats / step).to_i * step
		i = pi if pi < repeats && pi > i
		# step = i - cache[key][:i]
		# pi = (repeats / step) * step
		# i = pi if pi < repeats
		pp cache
		cache = {}
		next
	end

	tilt input, :north
	tilt input, :west
	tilt input, :south
	tilt input, :east
	puts "#{i}"
	# print input

	cache[key] = { :i => i, :map => input.join(',') }
	puts sum input
	i += 1
end

puts sum input
# print input

# 104409

#        0	11
#        1	44
#        2	32
#        4	17
#        5	14
#        6	22
#        7	32

#        8	17
#        9	14
#        10	22
#        11	32
#        12	17
#        13	14
#        14	22
#        15	32
#        16	17
#        17	14

#        14