#!/usr/bin/env ruby

input = <<EOF
Generator A starts with 873
Generator B starts with 583
EOF

def process number, factor
	number * factor % 2147483647
end

a, b = input.split("\n").map{|l| l.split(' ').last.to_i }
sa, sb = [[ ], [ ]]

pair_idx = 0; sum = 0

while true do
	a = process a, 16807
	b = process b, 48271

	sa << a if a % 4 == 0
	sb << b if b % 8 == 0

	if sa[0] && sb[0]
		pair_idx += 1
		ea = sa.shift; eb = sb.shift
		sum += 1 if (ea & 0xffff) == (eb & 0xffff)
	end

	if pair_idx >= 5_000_000
		puts sum
		exit 0
	end
end
