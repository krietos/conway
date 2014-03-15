class Grid
  attr_reader(:cell_array, :x, :y)
  def initialize(x, y)
    @y = y
    @x = x
    @cell_array = []
    x.times do |x|
      y.times do |y|
        new_cell = Cell.new(' ', x, y)
        @cell_array << new_cell
      end
    end
  end

  def neighbor(pcell)
    @neighbors = []
    @cell_array.each do |cell|
      for i in (pcell.x-1)..(pcell.x+1)
        for j in (pcell.y-1)..(pcell.y+1)
          if (cell.x == i && cell.y == j) && pcell != cell
            @neighbors << cell
          end
        end
      end
    end
    @neighbors
  end

  def live_count(cell)
    live_count = 0
    neighbor(cell).each do |cell|
      if cell.state == '.'
        live_count += 1
      end
    end
    live_count
  end

  def play_god
    @cell_array.each do |val|
      if val.state == "."
        if live_count(val) < 2 || live_count(val) > 3
          val.murder
        else
          val.res
        end
      elsif val.state == " "
        if live_count(val) == 3
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