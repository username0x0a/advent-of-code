
require 'net/http'

uri = URI('https://adventofcode.com/2021/day/1/input')
req = Net::HTTP::Get.new(uri)
req['Cookie'] = 'session=53616c7465645f5f5f32930097c77c90bc603754f2fefc941ae17c86fc50da701574786af5b1f6a4c5dc33fc2ef4d559'

res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
  http.request(req)
}

input = res.body.split("\n").map{|e| e.to_i}

increased = 0

(3...input.count).each{|i|
	prev = input[i-3] + input[i-2] + input[i-1]
	now = input[i-2] + input[i-1] + input[i]
	increased +=1 if now > prev
}

puts increased
