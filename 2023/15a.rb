#!/usr/bin/env ruby

input = File.read '15.txt'

puts input.split(',').each.map{|word|
	current = 0
	word.chars.each{|c|
		current += c.ord
		current *= 17
		current = current % 256
	}
	current
}.reduce(:+)
