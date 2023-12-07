
require 'pp'

$crabs = `cat 07.txt`.split(",").map{|e| e.to_i }

puts "Avg: " + ($crabs.sum.to_f / $crabs.count.to_f).to_s

crabs = $crabs.sort
count = crabs.count

out = nil

if count % 2 == 1
	p = ((count + 1)/2) - 1
	out = crabs[p]
else
	p = (count / 2) - 1
	out = (crabs[p] + crabs[p+1])/2
end

puts "Median: " + out.to_s

puts
puts "Fuel: " + crabs.reduce(0){|sum, crab| sum + (out - crab).abs }.to_s
