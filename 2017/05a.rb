#!/usr/bin/env ruby

input = File.read "05.txt"
instructions = input.split("\n").map(&:to_i)

at = 0

(1..).each{|idx|
	jump = instructions[at]
	instructions[at] += 1
	at += jump
	if at > instructions.length-1
		puts idx
		break
	end
}
