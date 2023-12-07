
require 'pp'

input = `cat 17.txt`

class Integer
	def plusfact; (self*(self+1))/2; end
end

class String
	def colorize(color_code)
		"\e[#{color_code}m#{self}\e[0m"
	end
	def red; colorize(31); end
	def green; colorize(32); end
end

def printMap start, target, steps
	xpos = [start[0]]
	xpos << target[0].min
	xpos << target[0].max
	xpos << steps.map{|e| e[0]}
	xpos = xpos.flatten
	ypos = [start[1]]
	ypos << target[1].min
	ypos << target[1].max
	ypos << steps.map{|e| e[1]}
	ypos = ypos.flatten
	xpos = xpos.min..xpos.max
	ypos = ypos.min..ypos.max

	mapsize = [xpos.max-xpos.min+1, ypos.max-ypos.min+1]

	$tshift = [0, [ypos.max, 0].max]

	def tox x; x + $tshift[0]; end
	def toy y; -y + $tshift[1]; end

	map = []

	mapsize[1].times{|li| map << ('.' * mapsize[0]).split('') }

	target[0].each{|tx| target[1].each{|ty| map[toy ty][tox tx] = 'T'.red } }
	steps.each{|step| map[toy step[1]][tox step[0]] = '@'.green }
	map[toy start[1]][tox start[0]] = 'S'.red

	puts map.map{|line| line.join }.join"\n"
end

start = [0, 0]

input = input.sub('target area: ', '').split(', ')

tx = input.first.sub('x=','').split('..').map{|e|e.to_i}.sort
tx = Range.new tx.first, tx.last
ty = input.last.sub('y=','').split('..').map{|e|e.to_i}.sort
ty = Range.new ty.first, ty.last

target = [tx, ty]

xvelrange = 0..tx.max
yvelrange = [ty.max.abs*-1, ty.min.abs*-1].min-10..[ty.max.abs, ty.min.abs].max+10

xvelrange.each do |vx|
	next if vx.plusfact < tx.min
	yvelrange.each do |vy|
		pos = start.dup
		steps = []
		0.upto(10000){|step|
			pos[0] += [vx - step, 0].max if vx > 0
			pos[0] += [vx + step, 0].min if vx < 0
			pos[1] += vy - step
			steps << pos.dup
			break if pos[0] > tx.max || pos[1] < ty.min
			if (tx.min..tx.max).include?(pos[0]) && (ty.min..ty.max).include?(pos[1])
				puts
				puts "Config [#{vx},#{vy}]:"
				puts "Max y pos: #{ steps.map{|s|s[1]}.max }"
				puts
				break
				printMap start, target, steps
				puts
				break
			end
		}
	end
end








