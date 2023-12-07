
require 'pp'

input = `cat 16.txt`

class String
	def colorize(color_code)
		"\e[#{color_code}m#{self}\e[0m"
	end
	def green
		colorize(32)
	end
end

$mapping = {
	'0' => '0000', '1' => '0001', '2' => '0010', '3' => '0011',
	'4' => '0100', '5' => '0101', '6' => '0110', '7' => '0111',
	'8' => '1000', '9' => '1001', 'A' => '1010', 'B' => '1011',
	'C' => '1100', 'D' => '1101', 'E' => '1110', 'F' => '1111',
}

lines = input.split"\n"

versions_sum = 0

def parseHexPacket input
	parsePacket input.split('').map{|let| $mapping[let] }.join
end

def parsePacket input
	puts "[*] packet #{input}"
	version = input[0..2].to_i(2)
	puts "version #{version}"
	type = input[3..5].to_i(2)
	if type == 4
		group_idx = 6
		number_bits = ''
		while true
			group = input[group_idx..group_idx+4]
			group_idx += 5
			break if group.length < 5
			number_bits += group[1..]
			break if group.start_with? '0'
		end
		number = number_bits.to_i(2)
		puts "number " + number.to_s
		return { :number => number, :length => group_idx }
	else
		lentype = input[6].to_i(2)
		if lentype == 0
			sublen = input[7..7+15-1].to_i(2)
			puts "sublen " + sublen.to_s
			subpackets = input[7+15..]
			while true
				break if subpackets == nil || subpackets.length < 11
				packet = subpackets[0..11-1]
				break if packet == nil
				subpackets = subpackets[11..]
				puts '[**] sub'
				parsePacket packet
			end
		elsif lentype == 1
			subnum = input[7..7+11-1].to_i(2)
			puts "subnum " + subnum.to_s
			subpackets = input[7+11..]
			1.upto(subnum){|i|
				break if subpackets == nil || subpackets.length < 11
				packet = subpackets[0..11-1]
				break if packet == nil
				subpackets = subpackets[11..]
				puts '[**] sub'
				parsePacket packet
			}
		end
	end
end

lines.each{|line|
	next if line.start_with? '#'
	parseHexPacket line
	puts "--------------------------"
}





















