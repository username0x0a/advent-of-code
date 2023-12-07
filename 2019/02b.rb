#!/usr/bin/env ruby

file_input = `cat 02.txt`.split(',').map(&:to_i)

(0..99).each{|n|
(0..99).each{|v|
	index = 0
	input = file_input.dup
	input[1] = n
	input[2] = v
while true do
	opcode = input[index]
	case opcode
	when 1
		a = input[input[index+1]]
		b = input[input[index+2]]
		input[input[index+3]] = a + b
		index += 4
	when 2
		a = input[input[index+1]]
		b = input[input[index+2]]
		input[input[index+3]] = a * b
		index += 4
	when 99
		if input[0] == 19690720
			puts "noun: #{n}, verb: #{v} -> #{input[0]} -> #{100 * n + v}"
			exit 0
		end
		break
	else throw :oops end
end
}}
