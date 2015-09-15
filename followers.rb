require 'terminal-table'
require 'open-uri'
require 'json'


#To list followers of a user

puts "Enter the Username"
user = gets
user = user.chomp
row = []
iterator = 1
url = "https://api.github.com/users/#{user}/followers"
response = open(url).read
parse = JSON.parse(response)
parse.each do |name|
	row << [iterator, name["login"]]
	iterator = iterator + 1
end
table1= Terminal::Table.new :headings =>['Id','Users'] ,:rows => row 
puts "Followers"
puts table1
#To list following
iterator = 1
url = "https://api.github.com/users/#{user}/following"
response = open(url).read
parse = JSON.parse(response)
parse.each do |name|
	row << [iterator, name["login"]]
	iterator = iterator + 1
end
table2= Terminal::Table.new :headings =>['Id','Users'] ,:rows => row 
puts "Following"
puts table2