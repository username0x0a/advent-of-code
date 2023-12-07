#!/usr/bin/env ruby

input = `cat 03.txt`
wires = input.split("\n").map{|w| w.split(',') }

puts wires.map{|wire| 
	pos = [0,0]
	wire.reduce([]){|pts,step|
		val = step[1..].to_i
		case step[0]
		when 'L' then pts += (pos[0]-val..pos[0]).to_a.map{|i| [i,pos[1]] }; pos[0] -= val
		when 'R' then pts += (pos[0]..pos[0]+val).to_a.map{|i| [i,pos[1]] }; pos[0] += val
		when 'D' then pts += (pos[1]-val..pos[1]).to_a.map{|i| [pos[0],i] }; pos[1] -= val
		when 'U' then pts += (pos[1]..pos[1]+val).to_a.map{|i| [pos[0],i] }; pos[1] += val
		end
		pts
	}.uniq
}.reduce(:&)[1..].map{|pts| pts.map(&:abs).reduce(:+) }.min
