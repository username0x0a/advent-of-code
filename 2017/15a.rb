#!/usr/bin/env ruby

input = <<EOF
Generator A starts with 873
Generator B starts with 583
EOF

def process number, factor
	number * factor % 2147483647
end

a, b = input.split("\n").map{|l| l.split(' ').last.to_i }

puts (1..40000000).reduce(0){|sum,it|
	a = process a, 16807
	b = process b, 48271
	sum += 1 if (a & 0xffff) == (b & 0xffff)
	sum
}
