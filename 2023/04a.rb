#!/usr/bin/env ruby

cards = File.read('04.txt').split("\n")

puts cards.map{|card|
	correct, checked = card.sub(/.*: /,'').split('|')
	correct = correct.split ' '
	checked = checked.split ' '
	winning = correct & checked
	(2 ** (winning.count-1)).floor.to_i
}.reduce(:+)
