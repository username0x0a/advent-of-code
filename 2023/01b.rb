#!/usr/bin/env ruby

input = `cat 01.txt`
input = input.split("\n").map{|line|
	map = {
		'one'   => '1',
		'two'   => '2',
		'three' => '3',
		'four'  => '4',
		'five'  => '5',
		'six'   => '6',
		'seven' => '7',
		'eight' => '8',
		'nine'  => '9',
	}
	matches = line.scan /(?=(one|two|three|four|five|six|seven|eight|nine|1|2|3|4|5|6|7|8|9))/
	first = matches.first[0]
	last = matches.last[0]
	first = map[first] || first
	last = map[last] || last
	(first + last).to_i
}
puts input.sum
