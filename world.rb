class World

	def init_voting # Intro / Menu
		
		title = File.readlines("title.txt","r+")
  		title = title[0].split("\n")

		puts "\nWELCOME TO \n"
		puts title
		puts
		puts "Please select an option:"
		while true
			puts "\n-------------- Create | List | Update | Vote | Exit --------------"
			answer = gets
			answer = if answer.nil?
				%w[Create List Update Vote].sample
			else
				answer.chomp.downcase.capitalize!
			end

			case answer
			when "Create"
				new_citizen = add_decision()
				if new_citizen.is_a? Politician
					@politicians << new_citizen
				else
					@voters << new_citizen
				end
			when "List"
				list(@voters, @politicians)
			when "Update"
				update()
			when "Vote"
				vote()
			when "Exit"
				exit()
			else
				puts "Please enter a valid entry."
			end

		end
	end

	def initialize
		@voters = []
		@politicians = []
		@voting_republican = []
		@voting_democrat = []
	end

	def add_decision # Creates profile
		puts "What would you like to create?"
		puts "Politician | Voter"
		answer = gets
		if answer.nil?
			answer = ["Politician", "Voter"].sample
		else
			answer = answer.chomp.downcase.capitalize!
		end
		new_citizen = create(answer)
		if new_citizen.nil? 
			puts "Please select a valid entry."
			add_decision
		end
		return new_citizen
	end

	def create(answer)
		if answer == 'Politician'
			Politician.new
		elsif answer == 'Voter'
			Person.new
		else
			nil
		end
	end

	def list(people_list, politician_list)
		(people_list + politician_list).each { |citizen| puts "Name: #{citizen.name} | #{citizen.party} | #{citizen.citizen_type} | Voting towards: #{citizen.vote}" }
	end 

	def update
		puts "What would you like to update?"
		puts "Voter | Politician"
		answer = gets.chomp.downcase.capitalize!
		if answer == "Politician"
			puts "Which politician would you like to update?"
			answer = gets.chomp.downcase.capitalize!
			politician_info_updated(answer)
		elsif answer == "Voter"
			puts "Which voter would you like to update?"
			answer = gets.chomp.downcase.capitalize!
			voter_info_updated(answer)
		else
			puts "Please enter a valid entry."
			update()
		end
	end

	def politician_info_updated(person) # Updating politician info
		@politicians.each do |politician|
			if politician.name == person
				puts "Would you like to update their name?"
				puts "(Y)es | (N)o"
				answer = gets.chomp.downcase
				if answer.start_with?('y') || answer.start_with?('yes')
					puts "New name?"
					politician.name = gets.chomp.downcase.capitalize!
				end   
				puts "Would you like to update their views?"
				puts "(Y)es | (N)o"
				answer = gets.chomp.downcase
				if answer.start_with?('y') || answer.start_with?('yes')
					puts "New party?"
					politician.party = gets.chomp.downcase.capitalize!
				end
				return
			end	
		end
		puts "Couldn't find that entry."
	end

	def voter_info_updated(person) # Updating voters info
		@voters.each do |voter|
			if voter.name == person
				puts "Would you like to update their name?"
				puts "(Y)es | (N)o"
				answer = gets.chomp.downcase
				if answer.start_with?('y') || answer.start_with?('yes')
					puts "New name?"
					voter.name = gets.chomp.downcase.capitalize!
				end
				puts "Would you like to update their views?"
				puts "(Y)es | (N)o"
				answer = gets.chomp.downcase
				if answer.start_with?('y') || answer.start_with?('yes')
					puts "Select any of the following views:"
					puts
					puts "Liberal | Conservative | Tea Party | Socialist | Neutral"
					new_party = gets.chomp.downcase.capitalize!
				end
				return
			end
			puts "Couldn't find that entry."
		end
	end

	def vote # Politician response
		@politicians.each do |politician|
			(@voters + @politicians).each do |person|
				if person.citizen_type == "Politician"
					puts "This statement is outrageous!"
					puts
				else
					random_num = Random.new.rand(100) / 100.0
					person.deciding_politician(politician, random_num)
				end
			end
		end
		tally_vote()
	end

	def tally_vote # Final decision on voting

		flag = File.readlines("flag.txt","r+")
  		flag = flag[0].split("\n")

		(@voters + @politicians).each do |person|
			if person.vote == "Democrat"
				@voting_democrat << person
			end
			if person.vote == "Republican"
				@voting_republican << person
			end
		end

		if @voting_democrat.size > @voting_republican.size
			puts "The Democrats have taken control. They won #{@voting_democrat.size} to #{@voting_republican.size}. Congratulations!"
			puts
			puts flag

		elsif @voting_democrat.size < @voting_republican.size
			puts "The Republicans have taken control. They won #{@voting_republican.size} to #{@voting_democrat.size}. Congratulations!"
			puts
			puts flag

		else
			puts "The final votes ended in a draw. #{@voting_democrat.size} to #{@voting_republican.size}."
			puts "Control of Congress could not be decided."
			puts
		end
	end

end