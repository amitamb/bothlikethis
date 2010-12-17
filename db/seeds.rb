# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)


puts "Hello there Amit"

PossibleName.delete_all

File.open("./db/possible_names_list.txt").each { |line|

		PossibleName.create(:name => line.strip.downcase)

}

for possible_name in PossibleName.find(:all)

	puts possible_name.name

end

#open("http://openconcept.ca/sites/openconcept.ca/files/country_code_drupal_0.txt") do |countries|  
  #countries.read.each_line do |country|  
    #code, name = country.chomp.split("|")  
    #Country.create!(:name => name, :code => code)  
  #end  
#end 
