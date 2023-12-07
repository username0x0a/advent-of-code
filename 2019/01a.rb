#!/usr/bin/env ruby

input = `cat 01.txt`

puts input.split("\n").map{|n| n.to_i / 3 - 2 }.reduce(:+)
