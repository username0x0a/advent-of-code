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

start_nodes = nodes.values.filter{|node| node[:name].match(/..A$/) }
last_node_match = /..Z$/

puts start_nodes.map{|start|
	node = start
	counter = 0
	while true do
		path.each{|direction|
			node = direction == 'L' ? nodes[node[:desc][0]] : nodes[node[:desc][1]]
			counter += 1
		}
		break if node[:name].match(last_node_match)
	end
	counter
}.reduce(1){|lcm,val| lcm.lcm(val) }
