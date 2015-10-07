module Citizen

	def define_names
		answer = false
		while not answer
			puts "Name?"
			answer = gets.chomp.downcase.capitalize!
		end
		answer
	end

	def view_stats
		puts @name
		puts @party
		puts @citizen_type
	end

end