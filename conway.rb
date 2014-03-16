require('./lib/grid.rb')
require('./lib/cell.rb')
require('curses')
 

def conway

	grid_x = 50
	grid_y = 50
	new_grid = Grid.new(grid_x, grid_y)
	prng = Random.new
	new_grid.cell_array.each do |val|
		if prng.rand(0..1) == 0
			val.state = '.'
			val.pending = '.'
		end
	end
	Curses.curs_set(0)

	100.times do
		system "clear" or system "cls"
		new_grid.cell_array.each_with_index do |val, ind|
			if ind % grid_x == 0 && ind != 0
				print "\n"
			end
			print val.state + ' '
		end


		new_grid.play_god
		new_grid.next_gen
		sleep (1)
	end
end

conway

