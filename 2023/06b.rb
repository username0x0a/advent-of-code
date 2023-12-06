#!/usr/bin/env ruby

input = <<EOF
Time:        60     80     86     76
Distance:   601   1163   1559   1300
EOF

race = input.split("\n").map{|line| line.split(':').last.gsub(' ','').to_i }
time, distance = race[0], race[1]

puts 1.upto(time).reduce(0){|sum,hold|
	elapsed = hold * (time-hold)
	elapsed > distance ? sum + 1 : sum
}
