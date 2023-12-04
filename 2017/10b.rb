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
lengths = (input[1] || '').chars.map{|c|
	c.ord
} + [17, 31, 73, 47, 23]

map = (0...max).to_a
idx = 0
skip = 0

64.times{|n|
	lengths.each{|len|
		map.flip idx, len
		idx += len + skip
		idx = idx % max
		skip += 1
	}
}

pp map.each_slice(16).to_a.map{|c| c.reduce(:^) }.map{|n| "%.2x" % n }.join
