
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
	throw :badHR if hiright.length != 1

	three = alls.select{|e| e.length == 5 && e.index(hiright) != nil && e.index(lowleft) == nil }.first
	five = alls.select{|e| e.length == 5 && e != two && e != three }.first
	throw :bad35 if !three || !five

	# puts "one: #{one}"
	# puts "four: #{four}"
	# puts "seven: #{seven}"
	# puts "eight: #{eight}"
	# puts '----'
	# puts "six: #{six}"
	# puts "nine: #{nine}"
	# puts "zero: #{zero}"
	# puts '----'
	# puts "two: #{two}"
	# puts "three: #{three}"
	# puts "five: #{five}"

	mapping = {
		one => 1,
		two => 2,
		three => 3,
		four => 4,
		five => 5,
		six => 6,
		seven => 7,
		eight => 8,
		nine => 9,
		zero => 0,
	}

	# pp mapping

	throw :badMapping if mapping.count != 10

	sum += fulls.map{|full| 
		mapped = mapping[full]
		# puts "#{full} -> #{mapped}"
		throw :badMap if mapped == nil
		mapped
	}.join.to_i

}

puts sum

#  fff
# g   b
#  ddd
# c   e
#  aaa
