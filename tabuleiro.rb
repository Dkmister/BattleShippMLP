require_relative "agua.rb"
require_relative "mina.rb"
require_relative "navio.rb"
require_relative "submarino.rb"

class Tabuleiro
	
	def initialize(tam)
		if tam.is_a?(Integer)
			@unidades = 0
			@invisiveis = 0
			@tamanho = tam
			@matriz = Array.new(@tamanho) { Array.new(@tamanho, Agua.new) }
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
					print " ~ "
				end
			end
			print "\n"
		end
	end
	
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
	
	def adicionar(unidade)
		tentativas = 0
		
		while true
			linha = Random.rand(0..@tamanho-1)
			coluna = Random.rand(0..@tamanho-1)
			
			case Random.rand(0..1)
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
			end
			if tentativas > 100
				raise "Não foi encontrado espaço para inclusão da nova unidade"
			end
			tentativas = tentativas + 1
		end
		return false
	end

	def agua(x,y)
		if @matriz[x-1][y-1].is_a?(Agua)
			return true
		else
			return false
		end
	end

	def visivel(x,y)
		if !@matriz[x-1][y-1].is_a?(Agua) and
		   !@matriz[x-1][y-1].visivel
			@invisiveis -= 1
		end
		@matriz[x-1][y-1].visivel = true		
	end

	def unidades
		@unidades
	end

	def invisiveis
		@invisiveis
	end
end