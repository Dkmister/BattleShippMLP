require_relative "embarcacao.rb"

class Navio < Embarcacao
	def initialize
		@tipo = "3"
		@visivel = false		
	end
end