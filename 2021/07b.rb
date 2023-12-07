
require 'pp'

$crabs = `cat 07.txt`.split(",").map{|e| e.to_i }

puts "Avg: " + ($crabs.sum.to_f / $crabs.count.to_f).to_s

avg = ($crabs.sum.to_f / $crabs.count.to_f).floor.to_i
puts avg

sum = $crabs.reduce(0){|sum, crab|
	n = (crab - avg).abs
	sum + ((n * (n+1)) / 2)
}

puts
puts "Fuel: " + sum.to_s
