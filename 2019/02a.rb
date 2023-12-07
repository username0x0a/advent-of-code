#!/usr/bin/env ruby

input = `cat 02.txt`.split(',').map(&:to_i)
input[1] = 12
input[2] = 2
index = 0

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
		puts input[0]
		exit 0
	else throw :oops end
end
