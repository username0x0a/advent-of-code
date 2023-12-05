#!/usr/bin/env ruby

class Hash
	def performStep
		case self[:direction]
		when :up
			throw :oops if self[:position] <= 0
			self[:position] -= 1
			self[:direction] = :down if self[:position] == 0
		when :down
			throw :oops if self[:position] >= self[:range]-1
			self[:position] += 1
			self[:direction] = :up if self[:position] == self[:range]-1
		end
	end
	def collisionSeverity
		self[:position] == 0 ? self[:depth] * self[:range] : 0
	end
end

input = File.read '13.txt'

walls = input.split("\n").map{|wall|
	depth, range = wall.split(':').map(&:to_i)
	[depth, { :depth => depth, :range => range, :position => 0, :direction => :down }]
}.to_h

max_depth = walls[walls.keys.last][:depth]

puts 0.upto(max_depth).map{|step|
	wall = walls[step]
	severity = wall ? wall.collisionSeverity : 0
	walls.values.each(&:performStep)
	severity
}.sum
