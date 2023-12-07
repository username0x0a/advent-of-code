
require 'pp'

input = `cat 19.txt`

def dist x1, x2, y1, y2, z1, z2
	xdiff = x2-x1; ydiff = y2-y1; zdiff = z2-z1
	Math.sqrt(xdiff*xdiff + ydiff*ydiff + zdiff*zdiff)
end

class Scanner
	attr_accessor :name, :beacons, :distance_map
	def initialize name, beacons
		@name = name; @beacons = beacons
		dist_map = {}
		beacons.each{|b1|
			beacons.each{|b2|
				next if b1 == b2
				key = [b1.idx, b2.idx].sort.join','
				next if dist_map[key]
				dist = dist b1.x, b2.x, b1.y, b2.y, b1.z, b2.z
				dist_map[key] = dist
			}
		}
		@distance_map = dist_map
	end
end

class Beacon
	attr_accessor :idx, :x, :y, :z
	def initialize idx, x, y, z
		@idx = idx; @x = x; @y = y; @z = z
	end
end

scanners = input.split "\n\n"
scanners = scanners.map{|scanner|
	beacons = scanner.split "\n"
	name = beacons.shift
	beacons = beacons.each_with_index.map{|beacon,idx|
		x, y, z = beacon.split(',').map{|e|e.to_i}
		Beacon.new idx, x, y, z
	}
	Scanner.new name, beacons
}

# puts scanners.map{|s|s.distance_map}

# puts scanners[0].distance_map.values.count
# puts scanners[1].distance_map.values.count
# puts (scanners[0].distance_map.values & scanners[1].distance_map.values).count

distances_num = scanners.map{|scanner|scanner.distance_map.map{|k,v|v}}.flatten.sort.count

