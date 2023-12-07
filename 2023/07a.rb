#!/usr/bin/env ruby

input = File.read '07.txt'

$order = '23456789TJQKA'
$values = $order.split('').each_with_index.map{|l,i| [l, i+2] }.to_h

cards = input.split("\n")

five = []
four = []
full = []
three = []
pairs = []
pair = []
rest = []

cards.each{|card| 
	hand, bid = card.split(" ")
	groups = hand.split('')
		.each_with_object({}){|c,h| h[c] = 0 if !h[c]; h[c] += 1 }
		.each_with_object({}){|(l,c),h| h[c] = [] if !h[c]; h[c] << l }
		.map{|k,v| [k, v.map{|l| $values[l] }.sort.reverse] }
		.sort_by{|e|-e[0]}.to_h
	card = { :hand => hand, :bid => bid.to_i, :groups => groups } 
	if card[:groups][5] then five << card
	elsif card[:groups][4] then four << card
	elsif card[:groups][3] then
		if card[:groups][2] then full << card else three << card end
	elsif card[:groups][2] then 
		if card[:groups][2].count > 1 then pairs << card else pair << card end
	else rest << card end
}

def order cards
	cards.sort{|a,b|
		diff = $values[a[:hand][0]] - $values[b[:hand][0]]
		diff = $values[a[:hand][1]] - $values[b[:hand][1]] if diff == 0
		diff = $values[a[:hand][2]] - $values[b[:hand][2]] if diff == 0
		diff = $values[a[:hand][3]] - $values[b[:hand][3]] if diff == 0
		diff = $values[a[:hand][4]] - $values[b[:hand][4]] if diff == 0
		diff
	}
end

five = order five
four = order four
full = order full
three = order three
pairs = order pairs
pair = order pair
rest = order rest

all = rest + pair + pairs + three + full + four + five

puts all.each_with_index.map{|c,i| c[:bid] * (i+1) }.reduce(:+)
