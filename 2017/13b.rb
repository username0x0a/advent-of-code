#!/usr/bin/env ruby

class Hash
	def collisionSeverity
		self[:depth] * self[:range]
	end
	def collides step

		# 1 2 4 6 8 10
		# * * * * * *
		#   * * * * *
		#     * * * *
		#       * * *
		#         * *
		#           *

		#  0   1   2   3   4   5   6
		# [s] [s] ... ... [s] ... [s]
		# [ ] [ ]         [ ]     [ ]
		# [ ]             [ ]     [ ]
		#                 [ ]     [ ]

		hitter = self[:range] * 2 - 2
		step == 0 || step % hitter == 0
	end
end

input = File.read '13_test.txt'

walls = input.split("\n").map{|wall|
	depth, range = wall.split(':').map(&:to_i)
	[depth, { :depth => depth, :range => range }]
}.to_h

max_depth = walls[walls.keys.last][:depth]

(0..).each{|delay|

	sum = 0.upto(max_depth).map{|step|
		position = -delay + step
		wall = position >= 0 ? walls[position] : nil
		severity = wall && wall.collides(step) ? wall.collisionSeverity : 0

		puts "step #{step}: severity #{severity} position #{position}"
		# puts "positions: #{ walls.values.map{|w|w[:position]}.join(',') }"

		severity
	}.sum

	if sum == 0
		puts delay
		break
	end
}

# 88 nope