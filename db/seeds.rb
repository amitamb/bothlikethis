# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)


puts "Seeding database"

puts "Seeding PossibleName"

PossibleName.delete_all

File.open("./db/possible_names_list.txt").each { |line|

		PossibleName.create(:name => line.strip.downcase)

}

puts "seeding Topic"

Topic.delete_all

new_topic = Topic.new(:name => "Friends", :description => "Sitcom featurng 6 friends and their life in NewYork",
	  :image_url => "http://janeheller.mlblogs.com/friends.jpg", :image_attribution_text => "thanks for link http://janeheller.mlblogs.com/",
	  :time_to_show => Time.now)
	  
new_topic.save

puts "Seeding Completed Successfully"
