require_relative "Table.rb"

class Game

  def initialize(size_x, size_y)
    @table = Table.new(size_x, size_y)
    (@table.create_mines 5).each { |m| @table.add_target m }
    (@table.create_submarines 4).each { |s| @table.add_target s }
    (@table.create_ships 3).each { |s| @table.add_target s }
  end

  def play
    buffer = ""
    loop do
      puts "-----------------------------------------------"
      puts "|         1 = Mina       : 1 casa             |"
      puts "|         2 = Submarino  : 2 casas            |"
      puts "|         3 = Navio      : 3 casas            |"
      puts "-----------------------------------------------"

      @table.display

      if (buffer != "")
        puts "-----------------------------------------------"
        puts "#{buffer}"
        buffer = ""
      end

      destroyed = @table.targets.select do |t|
        is_destroyed = true
        o = t.origin
        for i in 0..t.cell_span - 1
          if t.direction == 'row'
            if (@table.shots.select { |s| s[:x] == o[:x]+i and s[:y] == o[:y] }).length == 0
              is_destroyed = false
            end
          else
            if (@table.shots.select { |s| s[:x] == o[:x] and s[:y] == o[:y]+i }).length == 0
              is_destroyed = false
            end
          end
        end
        is_destroyed
      end

      if @table.targets & destroyed == @table.targets
        puts "-----------------------------------------------"
        puts "Parabéns, você ganhou!"
        return
      end

      puts "-----------------------------------------------"
      puts "Jogadas: #{@table.shots}"
      puts "Alvos destruídos: #{destroyed}"
      puts "-----------------------------------------------"
      puts "Insira o número da linha ou -1 para sair:"
      puts "-----------------------------------------------"

      linha = gets.to_i
      if linha == -1
        exit
      end

      if linha >= 0 and linha <= (@table.cells.uniq { |c| c[:y] }).length - 1
        puts "Informe o número da coluna:"
        coluna = gets.to_i
        if coluna >= 0 and coluna <= (@table.cells.uniq { |c| c[:x] }).length - 1
          shot = {x: coluna, y:linha}
          @table.add_shot(shot)
          target = @table.targets.select { |t| t.occupies(shot) }
          if target.length > 0
            buffer = "Linha #{shot[:y]}, Coluna #{shot[:x]}: Acertou o alvo!"
          else
            buffer = "Linha #{shot[:y]}, Coluna #{shot[:x]}: Errou o alvo!"
          end
        else
          buffer = "Número da coluna inválido."
        end
      else
        buffer = "Número da linha inválido."
      end
    end
  end
end

puts "-----------------------------------------------"
puts "      GRUPO 404 APRESENTA: BATALHA NAVAL       "
puts "-----------------------------------------------"
g = Game.new(15, 15)
g.play
