#!/usr/bin/env ruby

input = File.read '05.txt'
input = input.split "\n\n"

seeds = input[0].split(': ').last.split(' ').map(&:to_i)
	.each_slice(2).map{|a| (a[0]..a[0]+a[1]-1) }

def parseMap input
	input.split("\n")[1..]
		.map{|v| v.split(' ').map(&:to_i) }
		.map{|a| { :dest => a[0], :src => (a[1]..a[1]+a[2]-1) } }
end

def backResolve map, input
	map.each{|rule|
		deststart = rule[:dest]
		destend   = deststart + rule[:src].size-1
		idx = input - deststart
		if idx >= 0 && idx < rule[:src].size
			return rule[:src].begin + idx
		end
	}
	input
end

maps = 1.upto(7).map{|i| parseMap input[i] }.reverse

(0..).each{|location|
	seed = maps.reduce(location){|num,map| backResolve map, num }
	seeds.each{|seedrange|
		next if !seedrange.include? seed
		puts location
		exit 0
	}
}
