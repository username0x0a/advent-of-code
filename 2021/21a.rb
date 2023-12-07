
require 'pp'

input = `cat 21.txt`
start_1, start_2 = input.split("\n").map{|line| line.split(": ").last.to_i}

board_size = 10

p1 = start_1
p2 = start_2

p1_score = 0
p2_score = 0

def dice value; val = value % 100; val = 100 if val == 0; val; end
def score field; field == 0 ? 10 : field; end

0.upto(1_000_000){|round|
	puts "# Round #{round+1}"
	roll = [1, 2, 3].map{|e|dice(e + 3*round)}
	puts "Roll: #{roll.join','}"
	incr = roll.reduce(0){|sum,num|num + sum}
	if round % 2 == 0
		p1 += incr
		p1 = p1 % 10
		p1_score += score p1
		puts "P1: #{p1_score}"
	else
		p2 += incr
		p2 = p2 % 10
		p2_score += score p2
		puts "P2: #{p2_score}"
	end
	puts '-----------'
	if p1_score >= 1000 || p2_score >= 1000
		puts "Winner: #{[p1_score, p2_score].max}"
		looser = [p1_score, p2_score].min
		out = ((round+1) * 3) * looser
		puts "Value: #{out}"
		break
	end
}



