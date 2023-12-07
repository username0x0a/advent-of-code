
require 'net/http'

uri = URI('https://adventofcode.com/2021/day/3/input')
req = Net::HTTP::Get.new(uri)
req['Cookie'] = 'session=53616c7465645f5f5f32930097c77c90bc603754f2fefc941ae17c86fc50da701574786af5b1f6a4c5dc33fc2ef4d559'

res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
  http.request(req)
}

input = res.body.split("\n")

ones = [0] * input.first.length

input.each{|line|
	line.split('').each_with_index{|e,i|
		ones[i] += 1 if e.to_i == 1
	}
}

puts ones
puts input.count

total = input.count
gamma = ones.dup
epsi = ones.dup

gamma = gamma.map!{|e| e > total/2 ? 1 : 0 }.join
epsi = epsi.map!{|e| e > total/2 ? 0 : 1 }.join

puts
gamma = gamma.to_i(2)
epsi = epsi.to_i(2)
puts gamma * epsi