class Grid
  attr_reader(:cell_array, :x, :y)
  def initialize(x, y)
    @y = y
    @x = x
    @cell_array = []
    (x * y).times do |x|
      new_cell = Cell.new(' ')
      @cell_array << new_cell
    end
    neighbor(x, y)
  end

  def neighbor(grid_x, grid_y)
    @cell_array.each_with_index do |cell, ind|
      if ind == 0 #top left
        cell.neighbors << @cell_array[ind + 1]
        cell.neighbors << @cell_array[ind + grid_x]
        cell.neighbors << @cell_array[ind + grid_x + 1]
      elsif ind == (grid_x - 1) #top right
        cell.neighbors << @cell_array[ind - 1]
        cell.neighbors << @cell_array[ind + grid_x]
        cell.neighbors << @cell_array[ind + grid_x - 1]
      elsif ind == (grid_x * grid_y - grid_x) # bottom left
        cell.neighbors << @cell_array[ind - grid_x]
        cell.neighbors << @cell_array[ind - grid_x + 1]
        cell.neighbors << @cell_array[ind + 1]
      elsif ind == (grid_x * grid_y - 1) # bottom right
        cell.neighbors << @cell_array[ind - grid_x]
        cell.neighbors << @cell_array[ind - grid_x - 1]
        cell.neighbors << @cell_array[ind - 1]
      elsif ind < grid_x #top
        cell.neighbors << @cell_array[ind + 1]
        cell.neighbors << @cell_array[ind - 1]
        cell.neighbors << @cell_array[ind + grid_x - 1]
        cell.neighbors << @cell_array[ind + grid_x]
        cell.neighbors << @cell_array[ind + grid_x + 1]
      elsif ind % grid_x == 0 # left
        cell.neighbors << @cell_array[ind + grid_x]
        cell.neighbors << @cell_array[ind - grid_x]
        cell.neighbors << @cell_array[ind + 1]
        cell.neighbors << @cell_array[ind + grid_x + 1]
        cell.neighbors << @cell_array[ind - grid_x + 1]
      elsif ind % grid_x == grid_x - 1 # right
        cell.neighbors << @cell_array[ind + grid_x]
        cell.neighbors << @cell_array[ind - grid_x]
        cell.neighbors << @cell_array[ind - 1]
        cell.neighbors << @cell_array[ind + grid_x - 1]
        cell.neighbors << @cell_array[ind - grid_x - 1]
      elsif ind > (grid_x * grid_y - grid_x) # bottom
        cell.neighbors << @cell_array[ind + 1]
        cell.neighbors << @cell_array[ind - 1]
        cell.neighbors << @cell_array[ind - grid_x]
        cell.neighbors << @cell_array[ind - grid_x + 1]
        cell.neighbors << @cell_array[ind - grid_x - 1]
      else # middle
        cell.neighbors << @cell_array[ind + 1]
        cell.neighbors << @cell_array[ind - 1]
        cell.neighbors << @cell_array[ind - grid_x]
        cell.neighbors << @cell_array[ind + grid_x]
        cell.neighbors << @cell_array[ind + grid_x + 1]
        cell.neighbors << @cell_array[ind + grid_x - 1]
        cell.neighbors << @cell_array[ind - grid_x - 1]
        cell.neighbors << @cell_array[ind - grid_x + 1]
      end
    end
  end

  def live_count(cell)
    live_count = 0
    cell.neighbors.each do |cell|
      if cell.state == '.'
        live_count += 1
      end
    end
    live_count
  end

  def play_god
    @cell_array.each do |val|
      lives = live_count(val)
      if val.state == "."
        if lives < 2 || lives > 3
          val.murder
        else
          val.res
        end
      elsif val.state == " "
        if lives == 3
          val.res
        else
          val.murder
        end
      end
    end
  end

  def next_gen
    @cell_array.each do | cell |
      cell.state = cell.pending
    end
  end
end
