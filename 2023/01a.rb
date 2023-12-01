#!/usr/bin/env ruby

input = `cat 01.txt`
input = input.split("\n").map{|line|
	line = line.gsub /[^0-9]/, ''
	(line[0] + line[-1]).to_i
}
puts input.sum
