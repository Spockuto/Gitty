require 'terminal-table'
require 'open-uri'
require 'json'
#To list  all repos of a user
puts "Enter the Username"
user = gets
user = user.chomp
url = "https://api.github.com/users/#{user}/repos"
response = open(url).read
data = JSON.parse(response)	
row = []
data.each do |list|
	row << [ list['name']  , list['stargazers_count'] ,list['fork']]
end
table = Terminal::Table.new :headings =>['Name','Stars','fork'],:rows => row 
puts table