require 'github_api'
require 'terminal-table'

#To list followers of a user

puts "Enter the Username"
user = gets
user = user.chomp
row = []
iterator = 1
Github.users.followers.list user do |name|
	row << [iterator, name["login"]]
	iterator = iterator + 1
end
table = Terminal::Table.new :headings =>['Id','Users'] ,:rows => row 
puts table

