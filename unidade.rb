class Unidade
	public
	def initialize
		@visivel = false
	end	

	def tipo
		@tipo
	end
	def visivel
		@visivel
	end
	def visivel=(val)
		if [true, false].include? val
			@visivel = val
		else
			raise "Valor inváido para o atributo visível"
		end
	end
end