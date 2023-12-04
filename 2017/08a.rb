#!/usr/bin/env ruby

class Hash
	def at key
		self[key] = 0 if self[key] == nil
		self[key]
	end
	def check instr
		val = self.at(instr[:creg])
		fun = instr[:cfun]
		amo = instr[:camo]
		case fun
		when '>'  then val >  amo
		when '>=' then val >= amo
		when '==' then val == amo
		when '!=' then val != amo
		when '<=' then val <= amo
		when '<'  then val <  amo
		else
			throw "Error: #{instr} unknown"
		end
	end
	def apply instr
		reg = instr[:reg]
		case instr[:fun]
		when 'inc' then self[reg] = self.at(reg) + instr[:amo]
		when 'dec' then self[reg] = self.at(reg) - instr[:amo]
		else
			throw "Error: cannot apply #{instr}"
		end
	end
end

input = File.read "08.txt"
instructions = input.split("\n")
instructions = instructions.map{|ins|
	parts = ins.split ' '
	{
		:reg => parts[0],
		:fun => parts[1],
		:amo => parts[2].to_i,
		:creg => parts[4],
		:cfun => parts[5],
		:camo => parts[6].to_i,
	}
}

registers = { } # 'a' => 1

instructions.each{|ins|
	registers.apply(ins) if registers.check(ins)
}

puts registers.values.max
