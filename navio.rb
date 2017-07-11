require_relative "embarcacao.rb"

class Navio < Embarcacao
	def initialize
		@tipo = "3"
		super()
	end
end