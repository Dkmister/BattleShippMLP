require_relative "Target.rb"

class Table
  def cells
    @cells
  end
  def targets
    @targets
  end
  def shots
    @shots
  end

  def num_of_cols
    cols = @cells.uniq { |c| c[:x] }
    return cols.length
  end
  def num_of_rows
    rows = @cells.uniq { |c| c[:y] }
    return rows.length
  end

  def add_target(target)
    @targets.push(target)
  end
  def add_shot(shot)
    @shots.push(shot)
  end

  def shot_cell(cell)
    return (@shots.select { |s| s[:x] == cell[:x] and s[:y] == cell[:y] }).length > 0
  end

  def destroyed_target(cell, direction, cell_span)
    if cell_span == 0
      return true
    elsif shot_cell(cell)
      if direction == 'row'
        destroyed_target({x: cell[:x] + 1, y: cell[:y]}, direction, cell_span - 1)
      else
        destroyed_target({x: cell[:x], y: cell[:y] + 1}, direction, cell_span - 1)
      end
    else
      return false
    end
  end

  def display
    lines = @cells.uniq { |c| c[:y] }
    lines = lines.map { |c| @cells.select { |a| c[:y] == a[:y] } }
    print "     "
    for i in 0..lines[0].length-1
      print format('%02d', i), " "
    end
    print "\n"
    lines.each do |l|
      print " ", format('%02d', l[0][:y]), " "
      l.each do |c|
        if shot_cell(c)
          target = @targets.select { |t| t.occupies(c) }
          if target.length > 0
            if destroyed_target(target[0].origin, target[0].direction, target[0].cell_span)
              print " ", target[0].display, " "
            else
              print " x "
            end
          else
            print " ~ "
          end
        else
          print " · "
        end
      end
      print "\n"
    end
  end

  def get_random_cell(max_x, max_y)
    x = rand(max_x)
    y = rand(max_y)
    return @cells.find { |c| (c[:x] == x) and (c[:y] == y) }
  end

  def create_mines(quantity)
    new_mine = Target.new('mine', 'row')
    cell = self.get_random_cell(self.num_of_cols, self.num_of_rows)
    target = @targets.find { |t| t.occupies( cell ) }
    while target
      cell = self.get_random_cell(self.num_of_cols, self.num_of_rows)
      target = @targets.find { |t| t.occupies( cell ) }
    end
    new_mine.set_origin(cell)

    if quantity == 0
      return Array.new().push(new_mine)
    else
      return Array.new().push(new_mine) + create_mines(quantity - 1)
    end
  end

  def create_submarines(quantity)
    direction = rand(2) == 1 ? 'row' : 'col'
    new_submarine = Target.new('submarine', direction)
    max_x = direction == 'row' ? 14 : 15
    max_y = direction == 'col' ? 14 : 15
    cell1 = self.get_random_cell(max_x, max_y)
    cell2 = direction == 'row' ? @cells.find { |c| (c[:x] == cell1[:x]+1) and (c[:y] == cell1[:y]) } : @cells.find { |c| (c[:x] == cell1[:x]) and (c[:y] == cell1[:y]+1) }
    target1 = @targets.find { |t| t.occupies( cell1 ) }
    target2 = @targets.find { |t| t.occupies( cell2 ) }
    while target1 or target2
      cell1 = self.get_random_cell(max_x, max_y)
      cell2 = direction == 'row' ? @cells.find { |c| (c[:x] == cell1[:x]+1) and (c[:y] == cell1[:y]) } : @cells.find { |c| (c[:x] == cell1[:x]) and (c[:y] == cell1[:y]+1) }
      target1 = @targets.find { |t| t.occupies( cell1 ) }
      target2 = @targets.find { |t| t.occupies( cell2 ) }
    end
    new_submarine.set_origin(cell1)

    if quantity == 0
      return Array.new().push(new_submarine)
    else
      return Array.new().push(new_submarine) + create_submarines(quantity - 1)
    end
  end

  def create_ships(quantity)
    direction = rand(2) == 1 ? 'row' : 'col'
    new_ship = Target.new('ship', direction)
    max_x = direction == 'row' ? 13 : 15
    max_y = direction == 'col' ? 13 : 15
    cell1 = self.get_random_cell(max_x, max_y)
    cell2 = direction == 'row' ? @cells.find { |c| (c[:x] == cell1[:x]+1) and (c[:y] == cell1[:y]) } : @cells.find { |c| (c[:x] == cell1[:x]) and (c[:y] == cell1[:y]+1) }
    cell3 = direction == 'row' ? @cells.find { |c| (c[:x] == cell1[:x]+2) and (c[:y] == cell1[:y]) } : @cells.find { |c| (c[:x] == cell1[:x]) and (c[:y] == cell1[:y]+2) }
    target1 = @targets.find { |t| t.occupies( cell1 ) }
    target2 = @targets.find { |t| t.occupies( cell2 ) }
    target3 = @targets.find { |t| t.occupies( cell3 ) }
    while target1 or target2 or target3
      target1 = @targets.find { |t| t.occupies( cell1 ) }
      target2 = @targets.find { |t| t.occupies( cell2 ) }
      target3 = @targets.find { |t| t.occupies( cell3 ) }
    end
    new_ship.set_origin(cell1)

    if quantity == 0
      return Array.new().push(new_ship)
    else
      return Array.new().push(new_ship) + create_ships(quantity - 1)
    end
  end

  def initialize(num_cols, num_rows)
    @cells = Array.new()
    # create cells
    for x in 0..num_cols
      for y in 0..num_rows
        @cells.push({ x: x, y: y })
      end
    end

    @shots = Array.new()
    @targets = Array.new()
  end
end
