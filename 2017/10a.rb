#!/usr/bin/env ruby

class Array
	def at idx
		self[adjIdx(idx)]
	end

	def set idx, value
		idx = idx % length
		self[idx] = value
	end

	def adjIdx idx
		idx % length
	end

	def flip idx, len
		nums = (idx...idx+len).map{|idx| at(idx) }.reverse
		nums.each_with_index{|num,nidx|
			set idx + nidx, num
		}
	end
end

input = File.read('10.txt').split("\n")
max = input[0].to_i
lengths = input[1].split(',').map(&:to_i)

map = (0...max).to_a
idx = 0
skip = 0

lengths.each{|len|
	map.flip idx, len
	idx += len + skip
	idx = idx % max
	skip += 1
}

puts map[0..1].reduce(:*)
