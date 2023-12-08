#!/usr/bin/env ruby

input = '372304-847060'
min, max = input.split('-').map(&:to_i)

puts min.upto(max).reduce(0){|sum,num|
	next sum if num.to_s.match(/(.)\1/) == nil
	snum = num.to_s.split('').map(&:to_i)
	next sum if snum[1..].zip(snum[0..-2]).map{|p| p.reduce(:-) }.map{|i| i >= 0 }.include?(false)
	next sum if (num.to_s.scan(/(.)\1/) - num.to_s.scan(/(.)\1\1/)).size == 0
	sum += 1
}
