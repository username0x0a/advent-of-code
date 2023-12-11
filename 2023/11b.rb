#!/usr/bin/env ruby

input = File.read '11.txt'

space = input.split("\n")

ywarp = (0...space.count).each.map{|y| space[y].match(/#/) ? nil : y }.compact
xwarp = (0...space.count).each.map{|x| space.each.map{|l| l[x] }.join.match(/#/) ? nil : x }.compact

galaxies = []

space.each_with_index{|line,y|
	line.chars.each_with_index{|slot,x|
		galaxies << [x,y] if slot == '#'
	}
}

expansion = 1_000_000
sum = 0

(0...galaxies.count-1).each{|first|
	(first+1...galaxies.count).each{|second|
		a = galaxies[first]
		b = galaxies[second]
		sumx = (a[0] - b[0]).abs
		sumy = (a[1] - b[1]).abs
		([a[0],b[0]].min+1..[a[0],b[0]].max-1).each{|x|
			sumx += expansion-1 if xwarp.include? x
		}
		([a[1],b[1]].min+1..[a[1],b[1]].max-1).each{|y|
			sumy += expansion-1 if ywarp.include? y
		}
		sum += sumx + sumy
	}
}

pp sum
