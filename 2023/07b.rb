#!/usr/bin/env ruby

$order = 'J23456789TQKA'
$values = $order.split('').each_with_index.map{|l,i| [l, i+2] }.to_h

class Symbol
	def value; {
		:rest => 1, :pair => 2, :pairs => 3, :three => 4,
		:full => 5, :four => 6, :five  => 7
	}[self]; end
end

class String
	def ordered
		ord = self.split('').sort{|a,b|
			res = self.scan(b).count <=> self.scan(a).count
			res = $values[b] <=> $values[a] if res == 0
			res
		}.join
		if (1..4).include? ord.scan('J').count
			nord = ord.gsub('J','')
			nord = (nord[0] * (5-nord.size)) + nord
			ord = nord
		end
		ord
	end
	def compare str
		diff = 0
		0.upto(4){|i| diff = $values[self[i]] - $values[str[i]]; break if diff != 0 }
		diff
	end
	def cls
		return :five   if self.match /(.)\1\1\1\1/
		return :four   if self.match /(.).*\1.*\1.*\1/
		return :full   if self.match /(.)\1\1(.)\2/
		return :three  if self.match /(.).*\1.*\1/
		return :pairs  if self.scan(/(.).*\1/).count == 2
		return :pair   if self.match /(.).*\1/
		:rest
	end
end

input = File.read '07.txt'
cards = input.split("\n")

cards = cards.map{|card|
	hand, bid = card.split(" ")
	ohand = hand.ordered
	card = { :hand => hand, :ohand => ohand, :bid => bid.to_i, :cls => ohand.cls }
}

cards = cards.sort{|a,b|
	res = a[:cls].value <=> b[:cls].value
	res = a[:hand].compare(b[:hand]) if res == 0
	res
}

puts cards.each_with_index.map{|c,i| c[:bid] * (i+1) }.reduce(:+)
