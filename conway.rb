require('./lib/grid.rb')
require('./lib/cell.rb')
 

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

	100.times do
		system "clear" or system "cls"
		for i in 0..new_grid.x-1 
			new_grid.cell_array.each do |val|
				if val.x == i
					print val.state + ' '
				end
			end
			print "\n"
		end

		new_grid.play_god
		new_grid.next_gen
		sleep (1)
	end
end

conway

