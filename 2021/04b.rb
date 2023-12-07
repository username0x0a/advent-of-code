
require 'pp'

input = `cat 04.txt`.split "\n\n"

nums = input[0].split(",").map{|e| e.to_i }
input = input[1..]

boards = input.map{|inp|
	arr = []
	lines = inp.split "\n"
	lines.each{|line|
		loaded = line.gsub(/\s+/, ' ').split(' ').map{|e| e.to_i }
		arr << loaded
	}
	arr
}

nums.each{|num|

	boards.each{|board|
		board.each{|line|
			line.map!{|elm| elm == num ? nil : elm }
		}
	}

	losing = boards.select{|board|
		done = false
		board.each{|line|
			done = done || line.select{|e| e != nil }.count == 0
			break if done
		}
		false if done
		0.upto(board.first.count-1).each{|i|
			sum = board.reduce(0){|sum, line| sum + (line[i] == nil ? 1 : 0) }
			done = done || sum == 5
			break if done
		}
		!done
	}

	if losing.count == 1
		boards = losing
	end

	if losing.count == 0

		puts "Number: #{num}"
		puts "Board:"; pp boards.first
		puts "Sum: #{ boards.first.flatten.compact.sum }"
		puts "Result: #{ boards.first.flatten.compact.sum * num }"
		exit

	end

}
