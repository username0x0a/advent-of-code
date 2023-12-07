
require 'net/http'

uri = URI('https://adventofcode.com/2021/day/3/input')
req = Net::HTTP::Get.new(uri)
req['Cookie'] = 'session=53616c7465645f5f5f32930097c77c90bc603754f2fefc941ae17c86fc50da701574786af5b1f6a4c5dc33fc2ef4d559'

res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
  http.request(req)
}

input = res.body.split "\n"

# input = <<EOF
# 00100
# 11110
# 10110
# 10111
# 10101
# 01111
# 00111
# 11100
# 10000
# 11001
# 00010
# 01010
# EOF
# input = input.split "\n"

width = input.first.length
count = input.count

values = input.dup
oxy = 0

(0...width).each{|idx|
	puts idx
	sum = values.reduce(0){|sum, line| sum + line[idx].to_i }
	sel = sum >= values.count/2.0 ? '1' : '0'
	values = values.select{|e| e[idx] == sel }
	puts values
	if values.count == 1
		oxy = values.first
		break
	end
}

values = input.dup
prefix = ''
scr = 0

(0...width).each{|idx|
	sum = values.reduce(0){|sum, line| sum + line[idx].to_i }
	sel = sum < values.count/2.0 ? '1' : '0'
	values = values.select{|e| e[idx] == sel }
	if values.count == 1
		scr = values.first
		break
	end
}

puts
puts oxy, oxy.to_i(2)
puts scr, scr.to_i(2)

puts oxy.to_i(2) * scr.to_i(2)
