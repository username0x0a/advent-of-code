#!/usr/bin/env ruby

cards = File.read('04.txt').split("\n")

cards = cards.map{|card|
	idx = card.split(':').first.gsub(/[^0-9]/,'').to_i
	correct, checked = card.sub(/.*: /,'').split('|')
	correct = correct.split(' ').map(&:to_i)
	checked = checked.split(' ').map(&:to_i)
	winning = correct & checked
	[idx, winning.count]
}.to_h

check = cards.keys.map{|key| [key, 1] }.to_h

sum = 0

while true
	check.keys.each{|key|
		next if check[key] == 0
		sum += 1
		check[key] -= 1
		winning = cards[key]
		winning = (key+1...key+1+winning).to_a
		winning.each{|idx| check[idx] += 1 }
	}
	break if check.values.reduce(:+) == 0
end

puts sum
