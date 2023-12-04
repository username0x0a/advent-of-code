#!/usr/bin/env ruby

input = File.read "04.txt"
passes = input.split "\n"

puts passes.reduce(0){|result, pass|
	words = pass.split " "
	words.count == words.uniq.count ? result + 1 : result
}