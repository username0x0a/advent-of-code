
require 'pp'

input = `cat 14.txt`
input, pairs = input.split "\n\n"

pairs = pairs.split("\n").reduce({}){|map,pair|
	key, value = pair.split(' -> ')
	map[key] = value
	map
}

1.upto(10){|x|
	out = ''
	1.upto(input.length-1){|i|
		inp = input[i-1] + input[i]
		out += input[i-1] + pairs[inp]
		out += input[i] if i == input.length-1
	}
	puts out
	input = out
}

counts = input.split('').uniq.reduce([]){|arr,letter|
	arr << input.count(letter)
	arr
}.sort

puts counts.max - counts.min
