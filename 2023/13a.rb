#!/usr/bin/env ruby

class Array
	def rotated
		(0...self.first.size).each.map{|i| self.map{|line| line[i] }.join }
	end
end

input = File.read '13.txt'
patterns = input.split("\n\n")

puts patterns.each.map{|pattern|
	pattern = pattern.split "\n"
	[pattern, pattern.rotated].each.map{|pat|
		0.upto(pat.size-2).each.map{|yst|
			matches = yst.downto(0).each_with_index.map{|yidx,i|
				upper = pat[yidx]
				lower = pat[yst+1+i]
				next nil if !upper || !lower
				upper == lower
			}
			lines = matches.include?(false) ? 0 : matches.count
			multi = pat == pattern ? 100 : 1
			lines * multi
		}.max
	}.reduce(:+)
}.reduce(:+)
