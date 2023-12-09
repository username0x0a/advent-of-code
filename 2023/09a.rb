#!/usr/bin/env ruby

input = File.read '09.txt'

values = input.split("\n").map{|line| line.split(' ').map(&:to_i) }

puts values.map{|line|
	lines = [line]
	while true do
		line = line[0..-2].zip(line[1..]).map{|a| a[1] - a[0] }
		lines << line
		break if line.reduce(:+) == 0
	end
	lines.each{|line| line << 'X' }
	prev_line = nil
	lines.reverse.each_with_index{|line,index|
		if index == 0 then line[-1] = 0
		else line[-1] = line[-2] + prev_line[-1] end
		prev_line = line
	}
	lines[0][-1]
}.reduce(:+)
