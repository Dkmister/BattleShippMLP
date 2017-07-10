class Target
  def type
    @type
  end
  def origin
    @origin
  end
  def direction
    @direction
  end
  def cell_span
    @cell_span
  end

  def display
    if @type == 'mine'
      return 'm'
    elsif @type == 'submarine'
      return 'u'
    elsif @type == 'ship'
      return 's'
    end
  end

  def occupied_cells
    cells = Array.new()
    cells.push(@origin)
    x = @origin[:x]
    y = @origin[:y]
    if cell_span > 1
      for i in 1..@cell_span-1
        if @direction == 'row'
          x += 1
        else
          y += 1
        end
        cells.push({x: x, y: y})
      end
    end
    return cells
  end

  def occupies(cell)
    cells = self.occupied_cells
    cells = cells.select { |c| c[:x] == cell[:x] and c[:y] == cell[:y] }
    return cells.length > 0
  end

  def initialize (type, origin, direction)
    if ['mine', 'submarine', 'ship'].include? type
      @type = type
      @origin = origin
      @direction = direction
      if @type == 'mine'
        @cell_span = 1
      elsif @type == 'submarine'
        @cell_span = 2
      elsif @type == 'ship'
        @cell_span = 3
      end
    end
  end
end
