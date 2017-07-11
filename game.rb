require_relative "tabuleiro.rb"

module Header
	def print_names
		puts "-----------------------------------------------"
		puts "      GRUPO 404 APRESENTA: BATALHA NAVAL       "
		puts "-----------------------------------------------"
	end
	
	def print_ship
		puts "-----------------------------------------------"
		puts "|         1 = Mina       : 1 casa             |"
		puts "|         2 = Submarino  : 2 casas            |"
		puts "|         3 = Navio      : 3 casas            |"
		puts "-----------------------------------------------"
	end
end

include Header
class Game
	public
	def initialize(tamanho)
		@tamanho = tamanho
		@tabuleiro = Tabuleiro.new(@tamanho)
		@tabuleiro.adicionar(Navio.new)
		@tabuleiro.adicionar(Navio.new)
		@tabuleiro.adicionar(Navio.new)
		@tabuleiro.adicionar(Submarino.new)
		@tabuleiro.adicionar(Submarino.new)
		@tabuleiro.adicionar(Submarino.new)
		@tabuleiro.adicionar(Submarino.new)
		@tabuleiro.adicionar(Submarino.new)
		@tabuleiro.adicionar(Mina.new)
		@tabuleiro.adicionar(Mina.new)
		@tabuleiro.adicionar(Mina.new)
		@tabuleiro.adicionar(Mina.new)
		@tabuleiro.adicionar(Mina.new)		
		@jogadas = 0
	end
	
	def play	
		buffer = ""	
		loop do

			Header.print_ship
			
			@tabuleiro.imprimir

			if (buffer != "")
				puts "-----------------------------------------------"
				puts "#{buffer}"
				buffer = ""		
			end

			if @tabuleiro.getInvisiveis == 0
				puts "-----------------------------------------------"
				puts "Parabéns, você ganhou!"
			end

			puts "-----------------------------------------------"
			puts "Jogadas: #{@jogadas}"
			puts "Células restantes: #{@tabuleiro.getInvisiveis}"
			puts "-----------------------------------------------"
			puts "Insira o número da linha ou 0 para sair:"
			puts "-----------------------------------------------"

			linha = gets.to_i
			if linha == 0
				exit
			end
			
			if linha == 99
				@tabuleiro.setTodosVisiveis
			else	
				if linha >= 1 and linha <= @tamanho
					puts "Informe o número da coluna:"
					coluna = gets.to_i
					if coluna >= 1 and coluna <= @tamanho
						if @tabuleiro.isAgua(linha, coluna)
							buffer = "Linha #{linha}, Coluna #{coluna}: Errou o alvo!"
						else
							buffer = "Linha #{linha}, Coluna #{coluna}: Acertou o alvo!"
							@tabuleiro.setVisivel(linha, coluna)
						end
						@jogadas += 1
					else
						buffer = "Número da coluna inválido."
					end
				else
					buffer = "Número da linha inválido."
				end
			end
		end
	end
end

Header.print_names
g = Game.new(15)
g.play