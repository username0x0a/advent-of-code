#!/usr/bin/env ruby

maxes = {:red => 12, :green => 13, :blue => 14}
colormap = {'red' => :red, 'green' => :green, 'blue' => :blue}
gamessum = 0

games = `cat 02.txt`.split("\n")
games.each{|game|
	idx = game.split(':').first.gsub(/[^0-9]/, '').to_i
	rounds = game.split(':').last.split(';')
	valid = rounds.map{|round|
		colors = round.split(',').map{|elm|
			[colormap[elm.gsub(/[^a-z]/, '')], elm.to_i]
		}.to_h.map{|key, value|
			maxes[key] >= value
		}
	}.flatten.index(false) == nil
	gamessum += idx if valid
}

puts gamessum
