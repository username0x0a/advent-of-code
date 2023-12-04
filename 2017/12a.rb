#!/usr/bin/env ruby

class Hash
	def register node, otherNode
		self[node] = [] if self[node] == nil
		self[otherNode] = [] if self[otherNode] == nil
		self[node] << otherNode if self[node].index(otherNode) == nil
		self[otherNode] << node if self[otherNode].index(node) == nil
	end
	def inspect node
		ret = self[node] || []
		self.delete(node)
		ret.each{|deep| ret += inspect deep }
		ret
	end
end

input = File.read '12.txt'

all_nodes = { }

input.split("\n").each{|rule|
	node, nodes = rule.split '<->'
	node = node.strip
	nodes = nodes.gsub(/[^0-9,]/,'').split(',')
	nodes.each{|on| all_nodes.register node, on }
}

puts all_nodes.inspect('0').uniq.count
