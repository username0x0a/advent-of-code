#!/usr/bin/env ruby

input = File.read '15.txt'

def hash str
	current = 0
	str.chars.each{|c|
		break if c.match(/[a-z]/) == nil
		current += c.ord
		current *= 17
		current = current % 256
	}
	current
end

boxes = {}

input.split(',').each{|word|
	lens = word.split(/[-=]/).first
	box = hash lens
	pow = word.split(/[-=]/).last.to_i if word.include? '='
	boxes[box] = {} if boxes[box] == nil
	if word.include? '='
		boxes[box][lens] = pow
	elsif word.include? '-'
		boxes[box].delete lens
	end
}

puts boxes.each.map{|bidx,box|
	box.each_with_index.map{|(lens,pow),lidx|
		(bidx + 1) * (lidx + 1) * pow
	}.reduce(:+) || 0
}.reduce(:+)
