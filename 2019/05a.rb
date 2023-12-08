#!/usr/bin/env ruby

input = `cat 05.txt`
input = input.split(',').map(&:to_i)

index = 0

while true do
	op = '%08d' % input[index]
	opcode = op[-2..].to_i
	parmmodes = [op[-3], op[-4], op[-5], op[-6]].map(&:to_i)
	case opcode
	when 1
		a = parmmodes[0] == 1 ? input[index+1] : input[input[index+1]]
		b = parmmodes[1] == 1 ? input[index+2] : input[input[index+2]]
		input[input[index+3]] = a + b
		index += 4
	when 2
		a = parmmodes[0] == 1 ? input[index+1] : input[input[index+1]]
		b = parmmodes[1] == 1 ? input[index+2] : input[input[index+2]]
		input[input[index+3]] = a * b
		index += 4
	when 3
		input[input[index+1]] = 1
		index += 2
	when 4
		puts parmmodes[0] == 1 ? input[index+1] : input[input[index+1]]
		index += 2
	when 99
		exit 0
	else throw :oops end
end
