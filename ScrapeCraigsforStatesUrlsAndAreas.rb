require 'open-uri'
require 'nokogiri'
require 'csv'

url ="https://www.craigslist.org/about/sites"

page = Nokogiri::HTML(open(url))



	area_name = []
	page.css('div.colmask h4').each do |line|
		area_name << line.text
	end

	state_list = []
	page.css('div.colmask ul').each do |line|
		state_list << line
	end


	CSV.open("criags.csv", "w") do |file|
		file << ["URL", "State_Name", "Area_name"]

		state_list.length.times do |i|
			state_list[i].css('li a').each do |a|
				file << [a['href'], area_name[i], a.text]
			end
		end
	end