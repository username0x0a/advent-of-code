
require 'pp'

input = `cat 14_demo.txt`
input, pairs = input.split "\n\n"

pairs = pairs.split("\n").reduce({}){|map,pair|
	key, value = pair.split(' -> ')
	map[key] = value
	map
}

cache = {}

1.upto(40){|x|
	start = Time.new

	out = ''

	chunksize = 1000*2
	chunksnum = (input.length / chunksize) + 1

	0.upto(chunksnum-1){|idx|
		chunk = input[idx*chunksize..idx*chunksize+chunksize]
		# puts chunk
		if idx > 0
			key = out[-1] + chunk[0]
			out += pairs[key]
		end
		cached = cache[chunk]
		if cached
			out += cached
		else
			outi = ''
			1.upto(chunk.length-1){|i|
				inp = chunk[i-1] + chunk[i]
				outi += chunk[i-1] + pairs[inp]
				outi += chunk[i] if i == chunk.length-1
			}
			out += outi
			cache[chunk] = outi
		end
	}

	# puts out
	input = out
	puts "Round #{x}"
	puts "- input #{input}"
	puts "- length #{input.length}"
	puts "- took #{Time.new-start}s"
}

counts = input.split('').uniq.reduce([]){|arr,letter|
	arr << input.count(letter)
	arr
}.sort

puts counts.max - counts.min
