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
    @shots.push(target)
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
        target = @targets.select { |t| t.occupies(c) }
        if target.length > 0
          print " ", target[0].display, " "
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
    initial_targets_length = self.targets.length
    while targets.length - initial_targets_length < quantity do
      cell = self.get_random_cell(self.num_of_cols, self.num_of_rows)
      target = @targets.find { |t| t.occupies( cell ) }
      if not target
        self.add_target(Target.new('mine', cell, 'row' ))
      end
    end
  end

  def create_submarines(quantity)
    initial_targets_length = self.targets.length
    while targets.length - initial_targets_length < quantity do
      direction = rand(2) == 1 ? 'row' : 'col'
      max_x = direction == 'row' ? 14 : 15
      max_y = direction == 'col' ? 14 : 15
      cell1 = self.get_random_cell(max_x, max_y)
      cell2 = direction == 'row' ? @cells.find { |c| (c[:x] == cell1[:x]+1) and (c[:y] == cell1[:y]) } : @cells.find { |c| (c[:x] == cell1[:x]) and (c[:y] == cell1[:y]+1) }
      target1 = @targets.find { |t| t.occupies( cell1 ) }
      target2 = @targets.find { |t| t.occupies( cell2 ) }
      if not target1 and not target2
        self.add_target(Target.new('submarine', cell1, direction ))
      end
    end
  end

  def create_ships(quantity)
    initial_targets_length = self.targets.length
    while targets.length - initial_targets_length < quantity do
      direction = rand(2) == 1 ? 'row' : 'col'
      max_x = direction == 'row' ? 13 : 15
      max_y = direction == 'col' ? 13 : 15
      cell1 = self.get_random_cell(max_x, max_y)
      cell2 = direction == 'row' ? @cells.find { |c| (c[:x] == cell1[:x]+1) and (c[:y] == cell1[:y]) } : @cells.find { |c| (c[:x] == cell1[:x]) and (c[:y] == cell1[:y]+1) }
      cell3 = direction == 'row' ? @cells.find { |c| (c[:x] == cell1[:x]+2) and (c[:y] == cell1[:y]) } : @cells.find { |c| (c[:x] == cell1[:x]) and (c[:y] == cell1[:y]+2) }
      target1 = @targets.find { |t| t.occupies( cell1 ) }
      target2 = @targets.find { |t| t.occupies( cell2 ) }
      target3 = @targets.find { |t| t.occupies( cell3 ) }
      if not target1 and not target2 and not target3
        self.add_target(Target.new('ship', cell1, direction ))
      end
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

t = Table.new(15, 15)
t.create_mines 5
t.create_submarines 4
t.create_ships 3
t.display
