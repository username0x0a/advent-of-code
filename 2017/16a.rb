#!/usr/bin/env ruby

def spin dancers, amount
	dancers += dancers.shift(dancers.count-amount)
end
def exchange dancers, i, j
	tmp = dancers[i]
	dancers[i] = dancers[j]
	dancers[j] = tmp
	dancers
end
def partner dancers, a, b
	ia = dancers.index a
	ib = dancers.index b
	exchange dancers, ia, ib
end

input = File.read '16.txt'

dancers = input.split("\n")[0].split ''
instructions = input.split("\n")[1].split ','

instructions.each{|instruction|
	case instruction
	when /^s/
		amount = instruction[1..].to_i
		dancers = spin dancers, amount
	when /^x/
		i, j = instruction[1..].split('/').map(&:to_i)
		dancers = exchange dancers, i, j
	when /^p/
		a, b = instruction[1..].split('/')
		dancers = partner dancers, a, b
	end
}

puts dancers.join ''
