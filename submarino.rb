require_relative "embarcacao.rb"

class Submarino < Embarcacao
	def initialize
		@tipo = "2"
		@visivel = false
	end
end