
require 'pp'

openers = {
	'(' => 3,
	'[' => 57,
	'{' => 1197,
	'<' => 25137,
}

map = {
	')' => '(',
	']' => '[',
	'}' => '{',
	'>' => '<',
}

lines = `cat 10.txt`.split("\n")

scores = lines.map{|line|

	ret = nil
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
				ret = char
				break
			else
				stack.pop
			end
		end
	}

	ret

}

puts scores.compact.map{|closer| openers[map[closer]] }.reduce(&:+)
