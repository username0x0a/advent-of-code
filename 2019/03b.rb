#!/usr/bin/env ruby

input = `cat 03.txt`

wires = input.split("\n").map{|w| w.split(',') }

wiremaps = wires.map{|wire| 
	pos = [0,0]
	wire.reduce([]){|pts,step|
		val = step[1..].to_i
		case step[0]
		when 'L' then pts += (pos[0]-val..pos[0]).to_a.map{|i| [i,pos[1]] }.reverse[1..]; pos[0] -= val
		when 'R' then pts += (pos[0]..pos[0]+val).to_a.map{|i| [i,pos[1]] }[1..]; pos[0] += val
		when 'D' then pts += (pos[1]-val..pos[1]).to_a.map{|i| [pos[0],i] }.reverse[1..]; pos[1] -= val
		when 'U' then pts += (pos[1]..pos[1]+val).to_a.map{|i| [pos[0],i] }[1..]; pos[1] += val
		end
		pts
	}
}

wire1 = wiremaps[0]
wire2 = wiremaps[1]
cxs = (wire1 & wire2).map{|pt| [pt, []] }.to_h

wire1.each_with_index{|pt,i| next if cxs[pt] == nil; cxs[pt] << i+1 if cxs[pt].size == 0 }
wire2.each_with_index{|pt,i| next if cxs[pt] == nil; cxs[pt] << i+1 if cxs[pt].size == 1 }

pp cxs.values.map{|steps| steps.reduce(:+) }.min
