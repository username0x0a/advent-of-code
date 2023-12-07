
require 'pp'

class Node
	attr_accessor :id, :big, :edges
	def initialize id
		@id = id
		@big = id.upcase == id
		@edges = []
	end
end

class Edge
	attr_accessor :from, :to
	def initialize from, to
		@from = from
		@to = to
	end
end

lines = `cat 12.txt`.split "\n"

nodes = {}
edges = []

lines.each{|line|
	(from, to) = line.split'-'
	fromNode = nodes[from]
	if !fromNode
		fromNode = Node.new from
		nodes[from] = fromNode
	end
	toNode = nodes[to]
	if !toNode
		toNode = Node.new to
		nodes[to] = toNode
	end
	edgeFrom = Edge.new(fromNode, toNode)
	edgeTo = Edge.new(toNode, fromNode)
	edges << edgeFrom
	edges << edgeTo
	fromNode.edges << edgeFrom
	toNode.edges << edgeTo
}

start = nodes['start']
finish = nodes['end']

throw :bad if !start || !finish

$paths = []

def inspectEdge edge, path
	toNode = edge.to
	return if toNode.id == 'start'
	return if path.include?(toNode.id) && !toNode.big
	newPath = path.dup
	newPath << toNode.id
	if toNode.id == 'end'
		$paths << newPath.join(',')
		return
	end
	toNode.edges.each{|edge| inspectEdge edge, newPath }
end

start.edges.each{|edge| inspectEdge edge, ['start'] }

puts $paths.count
