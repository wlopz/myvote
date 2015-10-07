class Politician

	include Citizen

	attr_reader :party, :vote, :name, :citizen_type

	def initialize
		@name = define_names
		@party = define_views
		@citizen_type = "Politician"
		@vote = @party
	end

	def define_views
		answer = false
		while not answer
			puts "Please select your party:"
			puts "Democrat | Republican"
			answer = gets.chomp.downcase.capitalize!
		end
		answer
	end
end