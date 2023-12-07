
require 'pp'

input = `cat 21_demo.txt`
start_1, start_2 = input.split("\n").map{|line| line.split(": ").last.to_i}

$board_size = 10
$stop_score = 8

def score field; field == 0 ? $board_size : field; end

$p1_wins = 0
$p2_wins = 0

def printScore
	return if ($p1_wins + $p2_wins) % 1_000_000 != 0
	puts "P1: #{$p1_wins}, P2: #{$p2_wins}"
end

def round rnd, p1pos, p2pos, p1score, p2score
	(0...3**3).each{|thro|
		lp1pos = p1pos; lp2pos = p2pos; lp1score = p1score; lp2score = p2score
		# puts "round #{rnd} thro #{thro}"
		roll = "%03d" % thro.to_s(3)
		roll = roll.split('').map{|e|e.to_i+1}
		# puts "Roll #{roll.join''}"
		incr = roll.reduce(0){|sum,num|num + sum}
		if rnd % 2 == 0
			lp1pos += incr
			lp1pos = lp1pos % $board_size
			lp1score += score lp1pos
		else
			lp2pos += incr
			lp2pos = lp2pos % $board_size
			lp2score += score lp2pos
		end
		if lp1score >= $stop_score
			# puts "p1 wins"
			$p1_wins += 1
			printScore
			next
		elsif lp2score >= $stop_score
			# puts "p2 wins"
			$p2_wins += 1
			printScore
			next
		else
			round rnd+1, lp1pos, lp2pos, lp1score, lp2score
		end
	}
end

round 0, start_1, start_2, 0, 0

printScore
