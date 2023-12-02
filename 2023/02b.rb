#!/usr/bin/env ruby

colormap = {'red' => :red, 'green' => :green, 'blue' => :blue}
powersum = 0

games = `cat 02.txt`.split("\n").each{|game|
	gamemaxes = {:red => 0, :green => 0, :blue => 0}
	game.split(':').last.split(';').each{|round|
		round.split(',').map{|elm|
			sym = colormap[elm.gsub(/[^a-z]/, '')]
			gamemaxes[sym] = [gamemaxes[sym], elm.to_i].max
		}
	}
	powersum += gamemaxes.values.reduce(:*)
}

puts powersum
