#!/usr/bin/env ruby

class String
	def indices e
		start, result = -1, []
		result << start while start = (self.index e, start + 1)
		result
	end
end

lines = File.read('03.txt').split("\n")
parts = []

lines.each_with_index{|line,y|
	nums = line.scan(/[0-9]{1,}/).uniq
	nums = nums.map{|n| {:num => n, :idx => line.indices(/\b#{n}\b/)} }
	nums.each{|part|
		part[:idx].each{|idx|
			minY = [y-1,0].max
			maxY = [y+1,lines.count-1].min
			minX = [idx-1,0].max
			maxX = [idx+1+part[:num].length, line.length-1].min
			hasSymbol = (minY..maxY).map{|y|
				lines[y][minX...maxX].match(/[^0-9\.]/) != nil
			}.index(true) != nil
			parts << part[:num].to_i if hasSymbol
		}
	}
}

puts parts.sum
