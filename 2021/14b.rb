
require 'pp'

input = `cat 14.txt`
input, mapping = input.split "\n\n"

mapping = mapping.split("\n").reduce({}){|map,pair|
	key, value = pair.split(' -> ')
	map[key] = value
	map
}

pairs = {}

input = input.split''

first_letter = input[0]
last_letter = input[-1]

(1...input.count).each{|idx|
	pair = input[idx-1] + input[idx]
	pairs[pair] = 0 if !pairs[pair]
	pairs[pair] += 1
}

puts pairs

1.upto(40){|step|

	new_pairs = {}
	pairs.each{|pair,value|
		middle = mapping[pair]
		puts "Pair #{pair}" if !middle
		throw :bad if !middle
		[pair[0]+middle, middle+pair[-1]].each{|new_pair|
			new_pairs[new_pair] = 0 if !new_pairs[new_pair]
			new_pairs[new_pair] += value
		}
	}
	pairs = new_pairs

	puts pairs
	puts

	letter_counts = {}
	first_letters = pairs.keys.map{|key| key[0]}.uniq

	first_letters.each{|letter|
		sum = pairs.filter{|k,v| k[0] == letter}.map{|k,v|v}.sum
		letter_counts[letter] = sum
	}

	letter_counts[last_letter] += 1

	letter_counts = letter_counts.sort{|a,b| b[1] <=> a[1] }

	puts letter_counts.first[1] - letter_counts.last[1]
	puts

}
