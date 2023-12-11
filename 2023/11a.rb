#!/usr/bin/env ruby

input = File.read '11.txt'

space = input.split("\n")
space = space.map{|line| next [line] * 2 if line.match(/^[.]+$/); [line] }.flatten
space = (0...space.count).each.map{|i| space.map{|line| line[i] }.join }.filter{|l| l.length > 0 }
space = space.map{|line| next [line] * 2 if line.match(/^[.]+$/); [line] }.flatten
space = (0...space.count).each.map{|i| space.map{|line| line[i] }.join }.filter{|l| l.length > 0 }

galaxies = []

space.each_with_index{|line,y|
	line.chars.each_with_index{|slot,x|
		galaxies << [x,y] if slot == '#'
	}
}

sum = 0

(0...galaxies.count-1).each{|first|
	(first+1...galaxies.count).each{|second|
		a = galaxies[first]
		b = galaxies[second]
		sum += (a[0] - b[0]).abs + (a[1] - b[1]).abs
	}
}

pp sum
