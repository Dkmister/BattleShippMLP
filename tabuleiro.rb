require_relative "agua.rb"
require_relative "navio.rb"

class Tabuleiro
	
	def initialize(tam)
		if tam.is_a?(Integer)
			@tamanho = tam
			@matriz = Array.new(@tamanho) { Array.new(@tamanho, Agua.new) }
		else
			raise "tamanho do tabuleiro deve ser numerico"
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

end