require_relative "agua.rb"
require_relative "mina.rb"
require_relative "navio.rb"
require_relative "submarino.rb"

class Tabuleiro

	private
	def inserir(linha, coluna, unidade, orientacao)
		case unidade
			when Mina
				if @matriz[linha][coluna].is_a?(Agua)
					@matriz[linha][coluna] = unidade.clone
					@unidades += 1
					@invisiveis += 1
					return true
				end

			when Submarino
				case orientacao
					when "horizontal"
						if @matriz[linha][coluna].is_a?(Agua) and
						   @matriz[linha+1][coluna].is_a?(Agua)
								@matriz[linha][coluna] = unidade.clone
								@matriz[linha+1][coluna] = unidade.clone
								@unidades += 2
								@invisiveis += 2
								return true
						end
					when "vertical"
						if @matriz[linha][coluna].is_a?(Agua) and
						   @matriz[linha][coluna+1].is_a?(Agua)
								@matriz[linha][coluna] = unidade.clone
								@matriz[linha][coluna+1] = unidade.clone
								@unidades += 2
								@invisiveis += 2								
								return true
						end
				end

			when Navio
				case orientacao
					when "horizontal"
						if @matriz[linha][coluna].is_a?(Agua) and
						   @matriz[linha+1][coluna].is_a?(Agua) and
						   @matriz[linha+2][coluna].is_a?(Agua)
								@matriz[linha][coluna] = unidade.clone
								@matriz[linha+1][coluna] = unidade.clone
								@matriz[linha+2][coluna] = unidade.clone
								@unidades += 3
								@invisiveis += 3								
								return true
						end
					when "vertical"
						if @matriz[linha][coluna].is_a?(Agua) and
						   @matriz[linha][coluna+1].is_a?(Agua) and
						   @matriz[linha][coluna+2].is_a?(Agua)							   
								@matriz[linha][coluna] = unidade.clone
								@matriz[linha][coluna+1] = unidade.clone
								@matriz[linha][coluna+2] = unidade.clone
								@unidades += 3
								@invisiveis += 3								
								return true							
						end						
				end
		end
		return false
	end
	
	# Uso de delagates
	def method_missing(method, *args)
		if num_aleatorio.respond_to?(method)
			num_aleatorio.send(method, *args)
		else
			super
		end
	end
	attr_reader :num_aleatorio


	public
	def initialize(tam)
		if tam.is_a?(Integer)
			@unidades = 0
			@invisiveis = 0
			@tamanho = tam
			@matriz = Array.new(@tamanho)
			for i in 0..@tamanho-1
				@matriz[i] = Array.new(@tamanho)
				for j in 0..@tamanho-1
					@matriz[i][j] = Agua.new
				end
			end
			@num_aleatorio = Random.new
		else
			raise "Tamanho do tabuleiro deve ser numérico"
		end
	end

	def imprimir
		for i in 0..@tamanho-1
			if i == 0
				for j in 0..@tamanho-1
					if j == 0
						print "   "
					end
					if j < 9
						print " #{j+1} "
					else
						print "#{j+1} "
					end
				end
				print "\n"
			end
			if i < 9
				print " #{i+1} "
			else
				print "#{i+1} "
			end
			for j in 0..@tamanho-1
				if @matriz[i][j].visivel
					print " #{@matriz[i][j].tipo} "
				else
					print " . "
				end
			end
			print "\n"
		end
	end
	
	def adicionar(unidade)
		tentativas = 0
		
		while true
			linha = num_aleatorio.rand(0..@tamanho-1)
			coluna = num_aleatorio.rand(0..@tamanho-1)
			
			case num_aleatorio.rand(0..1)
				when 0
					orientacao = "horizontal"
				when 1
					orientacao = "vertical"
			end
			
			case unidade
				when Mina
					if inserir(linha, coluna, unidade, orientacao)
						return true
					end

				when Submarino
					case orientacao
						when "horizontal"
							if linha + 1 < @tamanho and
							   inserir(linha, coluna, unidade, orientacao)
								   return true
							end
						when "vertical"
							if coluna + 1 < @tamanho and
							   inserir(linha, coluna, unidade, orientacao)
								   return true
							end
					end

				when Navio
					case orientacao
						when "horizontal"
							if linha + 2 < @tamanho and
							   inserir(linha, coluna, unidade, orientacao)
								   return true
							end

						when "vertical"
							if coluna + 2 < @tamanho and
							   inserir(linha, coluna, unidade, orientacao)
								   return true
							end				
					end

				else
					raise "Tipo de unidade não suportada"
			end
			
			if tentativas > 100
				raise "Não foi encontrado espaço para inclusão da nova unidade"
			end
			tentativas = tentativas + 1
		end
		return false
	end

	def isAgua(x,y)
		if x.is_a?(Integer) and
		   y.is_a?(Integer) and
		   x >= 1 and x <= @tamanho and
		   y >= 1 and y <= @tamanho
				if @matriz[x-1][y-1].is_a?(Agua)
					return true
				else
					return false
				end
		else
			raise "Parâmetro inválido"
		end
	end

	def setVisivel(x,y)
		if x.is_a?(Integer) and
		   y.is_a?(Integer) and
		   x >= 1 and x <= @tamanho and
		   y >= 1 and y <= @tamanho		
				if @matriz[x-1][y-1].is_a?(Agua) == false and
				   @matriz[x-1][y-1].visivel == false
					@invisiveis -= 1
				end
				@matriz[x-1][y-1].visivel = true
		else
			raise "Parâmetro inválido"
		end
	end

	def getUnidades
		@unidades
	end

	def getInvisiveis
		@invisiveis
	end
	
	def setTodosVisiveis
		for i in 1..@tamanho
			for j in 1..@tamanho
				setVisivel(i,j)
			end
		end
	end
	
end