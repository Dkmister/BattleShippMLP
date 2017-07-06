require_relative "tabuleiro.rb"

loop do
	puts "Olá, insira play ou sair"
	
	input = gets.chomp
	command, *params = input.split /\s/	
	
	case command
		when "play"
			t = Tabuleiro.new(15)
			t.imprimir

		when "sair"
			exit
			
		else
			puts "opção inválida"
	end

end