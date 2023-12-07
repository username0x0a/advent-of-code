
require 'pp'

lines = `cat 08.txt`.split("\n")

sum = 0

lines.each{|line|

	def its(x, y) 
		(x.split('') & y.split('')).count
	end

	trains, fulls = line.split " | "
	trains = trains.split(" ").map{|e| e.split('').sort.join }
	fulls = fulls.split(" ").map{|e| e.split('').sort.join }

	alls = (trains + fulls).flatten

	one = alls.select{|e| e.length == 2 }.first
	four = alls.select{|e| e.length == 4 }.first
	seven = alls.select{|e| e.length == 3 }.first
	eight = alls.select{|e| e.length == 7 }.first

	throw :bad if !one || !four || !seven || !eight

	six = alls.select{|e| e.length == 6 && its(e, one) == 1 }.uniq
	throw :bad6 if six.count != 1
	six = six.first

	nine = alls.select{|e| e.length == 6 && its(e, seven) == 3 && its(e, four) == 4 }.uniq
	throw :bad9 if nine.count != 1
	nine = nine.first

	zero = alls.select{|e| e.length == 6 && e != six && e != nine }.uniq
	throw :bad0 if zero.count != 1
	zero = zero.first

	lowleft = (eight.split('') - nine.split('')).join
	throw :badLL if lowleft.length != 1

	two = alls.select{|e| e.length == 5 && e.index(lowleft) != nil }.uniq
	throw :bad2 if two.count != 1
	two = two.first

	hiright = (seven.split('') - six.split('')).join
	throw :badHR if lowleft.length != 1

	three = alls.select{|e| e.length == 5 && e.index(hiright) != nil }.first
	five = alls.select{|e| e.length == 5 && e != two && e != three }.first
	throw :bad35 if !three || !five

	sum += fulls.reduce(0){|sum, full| sum + (full == one || full == four || full == seven || full == eight ? 1 : 0) }

}

puts sum
