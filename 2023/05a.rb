#!/usr/bin/env ruby

input = File.read '05.txt'
input = input.split "\n\n"

seeds = input[0].split(': ').last.split(' ').map(&:to_i)

def parseMap input
	input.split("\n")[1..]
		.map{|v| v.split(' ').map(&:to_i) }
		.map{|a| { :dest => a[0], :src => (a[1]..a[1]+a[2]-1) } }
end

def resolve map, input
	map.each{|rule|
		if rule[:src].include? input
			idx = input - rule[:src].begin
			return rule[:dest] + idx
		end
	}
	input
end

maps = 1.upto(7).map{|i| parseMap input[i] }

pp seeds.map{|seed|
	maps.reduce(seed){|num,map| resolve map, num }
}.min
