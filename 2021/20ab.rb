
require 'pp'

input = `cat 20.txt`
algo, image = input.split "\n\n"

image = image.split("\n").map{|line|line.split''}

class Array
	def at x, y, shiftx, shifty
		fb = self[y][x]
		x+shiftx >= 0 && y+shifty >= 0 && y+shifty < self.count ? (self[y+shifty][x+shiftx] || fb) : fb
	end
end

def addImagePadding image
	height = image.count
	width = image[0].count
	padding = 1
	image = ([ ['.'] * (width+2*padding) ] * padding) + 
	        image.map{|line| (['.'] * padding) + line + (['.'] * padding) } + 
	        ([ ['.'] * (width+2*padding) ] * padding)
	image = image.map{|line|line.map{|elm|elm.dup}.dup}
	image
end

puts image.map{|line|line.join''}.join"\n"
puts

60.times { image = addImagePadding image }

mapping = { '.' => '0', '#' => '1' }

1.upto(2){|round|
	newimage = image.map{|line|line.map{|elm|'.'}}
	image.each_with_index{|line,y|
		line.each_with_index{|char,x|
			val = [image.at(x, y, -1, -1), image.at(x, y, 0, -1), image.at(x, y, +1, -1),
			       image.at(x, y, -1,  0), image.at(x, y, 0,  0), image.at(x, y, +1,  0),
			       image.at(x, y, -1, +1), image.at(x, y, 0, +1), image.at(x, y, +1, +1)].flatten
			val = val.map{|c|mapping[c]}.join.to_i(2)
			newimage[y][x] = algo[val]
		}
	}
	image = newimage
}

puts image.map{|line|line.join''}.join"\n"
puts "Hi's: #{image.flatten.count('#')}"
puts

3.upto(50){|round|
	newimage = image.map{|line|line.map{|elm|'.'}}
	image.each_with_index{|line,y|
		line.each_with_index{|char,x|
			val = [image.at(x, y, -1, -1), image.at(x, y, 0, -1), image.at(x, y, +1, -1),
			       image.at(x, y, -1,  0), image.at(x, y, 0,  0), image.at(x, y, +1,  0),
			       image.at(x, y, -1, +1), image.at(x, y, 0, +1), image.at(x, y, +1, +1)].flatten
			val = val.map{|c|mapping[c]}.join.to_i(2)
			newimage[y][x] = algo[val]
		}
	}
	image = newimage
}

puts image.map{|line|line.join''}.join"\n"
puts "Hi's: #{image.flatten.count('#')}"
puts
