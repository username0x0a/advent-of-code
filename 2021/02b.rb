
require 'net/http'

uri = URI('https://adventofcode.com/2021/day/2/input')
req = Net::HTTP::Get.new(uri)
req['Cookie'] = 'session=53616c7465645f5f5f32930097c77c90bc603754f2fefc941ae17c86fc50da701574786af5b1f6a4c5dc33fc2ef4d559'

res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
  http.request(req)
}

input = res.body.split("\n")

depth = 0
fwd = 0
aim = 0

input.each{|step|
	cmd, val = step.split " "
	val = val.to_i
	case cmd
	when 'forward'
		fwd += val
		depth += aim * val
	when 'up'
		aim -= val
	when 'down'
		aim += val
	end
}

puts depth * fwd
