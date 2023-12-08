#!/usr/bin/env ruby

input = `cat 05.txt`
# input = '3,9,8,9,10,9,4,9,99,-1,8'
# input = '3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99'
# input = '3,3,1108,-1,8,3,4,3,99'
# input = '3,3,1107,-1,8,3,4,3,99'
input = input.split(',').map(&:to_i)

index = 0

while true do
	puts index
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
		input[input[index+1]] = 5
		index += 2
	when 4
		puts parmmodes[0] == 1 ? input[index+1] : input[input[index+1]]
		index += 2
	when 5
		val = parmmodes[0] == 1 ? input[index+1] : input[input[index+1]]
		index = input[index+2] if val > 0
	when 6
		val = parmmodes[0] == 1 ? input[index+1] : input[input[index+1]]
		index = input[index+2] if val == 0
	when 7
		a = parmmodes[0] == 1 ? input[index+1] : input[input[index+1]]
		b = parmmodes[1] == 1 ? input[index+2] : input[input[index+2]]
		input[input[index+3]] = a < b ? 1 : 0
		index += 4
	when 8
		a = parmmodes[0] == 1 ? input[index+1] : input[input[index+1]]
		b = parmmodes[1] == 1 ? input[index+2] : input[input[index+2]]
		input[input[index+3]] = a == b ? 1 : 0
		index += 4
	when 99
		exit 0
	else throw :oops end
end
