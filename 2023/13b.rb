#!/usr/bin/env ruby

require 'set'

class Array
	def rotated
		(0...self.first.size).each.map{|i| self.map{|line| line[i] }.join }
	end
end

def diff first, second
	(0...first.length).each.map{|i| first[i] != second[i] }.count(true)
end

input = File.read '13.txt'
patterns = input.split("\n\n")

puts patterns.each.map{|pattern|
	pattern = pattern.split "\n"
	[pattern, pattern.rotated].each.map{|pat|
		0.upto(pat.size-2).each.map{|yst|
			diffs = yst.downto(0).each_with_index.map{|yidx,i|
				upper = pat[yidx]
				lower = pat[yst+1+i]
				next nil if !upper || !lower
				diff upper, lower
			}
			next 0 if !([Set[0,1],Set[1]].include?(diffs.compact.to_set) && diffs.count(1) == 1)
			lines = diffs.count
			multi = pat == pattern ? 100 : 1
			lines * multi
		}.max
	}.reduce(:+)
}.reduce(:+)
