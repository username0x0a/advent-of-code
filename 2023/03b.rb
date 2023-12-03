#!/usr/bin/env ruby

class String
	def indices e
		start, result = -1, []
		result << start while start = (self.index e, start + 1)
		result
	end
end

lines = File.read('03.txt').split("\n")
stars = {}

lines.each_with_index{|line,y|
	nums = line.scan(/[0-9]{1,}/).uniq
	nums = nums.map{|n| {:num => n, :idx => line.indices(/\b#{n}\b/)} }
	nums.each{|num|
		num[:idx].each{|idx|
			minY = [y-1,0].max
			maxY = [y+1,lines.count-1].min
			minX = [idx-1,0].max
			maxX = [idx+1+num[:num].length, line.length-1].min
			(minY..maxY).each{|y|
				lines[y][minX...maxX].indices('*').map{|rx| rx + minX }.each{|x|
					idx = "#{x},#{y}"
					stars[idx] = [] if stars[idx] == nil
					stars[idx] << num[:num].to_i
				}
			}
		}
	}
}

puts stars.filter{|k,v| v.count == 2 }.values.map{|v| v.reduce(:*) }.sum
