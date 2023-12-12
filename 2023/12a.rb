#!/usr/bin/env ruby

input = File.read '12.txt'

springs = input.split "\n"

sum = 0

springs.each_with_index{|line,idx|

	line, stats = line.split ' '
	length = line.length


	line = line.gsub('.', '0').gsub('#', '1')
	stats = stats.split(',').map(&:to_i)

	pattern = line.gsub('?', '[01]')
	pattern = /#{pattern}/

	bits = stats.map{|i| ("1" * i) }.join('[0]+')
	bits = /#{bits}/

	0.upto(2 << length-1){|i|
		gen = "%0#{length}b" % i
		next if !gen.match(pattern) || !gen.match(bits) || gen.gsub('0','').length != stats.sum
		sum += 1
	}
}

puts sum
