#!/usr/bin/env ruby

input = File.read '08.txt'
input = input.split "\n\n"

path = input[0].split('')

nodes = input[1].split("\n").map{|line|
	name = line.split(' = ')[0]
	desc = line.split(' = ')[1]
	desc = desc.gsub(/[^A-Z0-9,]/, '').split(',')
	{ :name => name, :desc => desc }
}.map{|node| [node[:name], node] }.to_h

first_node = nodes['AAA']
last_node_name = 'ZZZ'

node = first_node
counter = 0

while true do
	path.each{|direction|
		node = direction == 'L' ? nodes[node[:desc][0]] : nodes[node[:desc][1]]
		counter += 1
	}
	break if node[:name] == last_node_name
end

puts counter
