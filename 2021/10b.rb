
require 'pp'

openers = {
	'(' => 1,
	'[' => 2,
	'{' => 3,
	'<' => 4,
}

map = {
	')' => '(',
	']' => '[',
	'}' => '{',
	'>' => '<',
}

lines = `cat 10.txt`.split("\n")

stacks = lines.map{|line|

	ret = true
	chars = line.split''
	stack = []
	chars.each{|char|
		if openers[char] != nil
			stack << char
		else
			closer = map[char]
			if !closer
				break
			elsif closer != stack.last
				ret = false
				break
			else
				stack.pop
			end
		end
	}

	ret = ret ? stack : nil

}.compact

scores = stacks.map{|stack|
	stack.reverse.reduce(0){|sum, opener| 5 * sum + openers[opener] }
}

scores = scores.sort
puts scores[scores.count/2]
