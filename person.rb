class Person
	
	include Citizen

	attr_accessor :vote, :name, :party, :citizen_type

	# Voting Logic
	INFO_DEM = { "Socialist" => 0.90/100, "Liberal" => 0.75/100, "Neutral" => 0.50/100, "Conservative" => 0.25/100, "Tea party" => 0.10/100 }

	INFO_REP = { "Tea party" => 0.90/100, "Conservative" => 0.75/100, "Neutral" => 0.50/100, "Liberal" => 0.25/100, "Socialist" => 0.10/100 }

	def initialize
		@name = define_names
		@party = define_views
		@citizen_type = "Voter"
		@vote = nil
	end

	def define_views
		answer = false
		while not answer
			puts "Please select your political view:"
			puts "Liberal | Conservative | Tea Party | Socialist | Neutral"
			answer = gets.chomp.downcase.capitalize!
		end
		answer
	end

	def deciding_politician(politician, random_num)
		case politician.party
		when "Democrat"
			chances = INFO_DEM[@party]
		when "Republican"
			chances = INFO_REP[@party]
		else
			puts "Weird... This should not occur!"
		end

		if (random_num <= chances)
			@vote = politician.party
			puts "I liked the ideas of this politician. Will support him!"
			puts
		else
			puts "Not convinced. Won't take my vote"
			puts
		end
	end

end