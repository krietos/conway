class Cell
  attr_reader(:x, :y)
  attr_accessor(:state, :pending, :neighbors)
  def initialize(state, x, y)
    @state = state
    @x = x
    @y = y
    @pending = ' '
    @neighbors = []
  end
  def res
    @pending = "."
  end
  def murder
    @pending = " "
  end
end
