#!/usr/bin/env ruby

input = File.read '14.txt'
input = input.split "\n"

input.each_with_index{|line,y|
	puts line
	next if y == 0
	0.upto(line.length-1).each{|x|
		if line[x] == 'O'
			newY = nil
			(y-1).downto(0).each{|fy|
				break if input[fy][x] != '.'
				if input[fy][x] == '.'
					newY = fy
					next
				end
			}
			if newY
				input[newY][x] = 'O'
				line[x] = '.'
			end
		end
	}
}

puts input.each_with_index.map{|line,y|
	line.count('O') * (input.size - y)
}.reduce(:+)
