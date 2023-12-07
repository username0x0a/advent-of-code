#!/usr/bin/env ruby

input = `cat 01.txt`
masses = input.split("\n").map{|n| n.to_i }

fuel_sum = 0

while true do
	fuel = masses.shift / 3 - 2
	masses << fuel if fuel > 0
	fuel_sum += fuel if fuel > 0
	break if masses.size == 0
end

puts fuel_sum
