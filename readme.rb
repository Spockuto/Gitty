require 'terminal-table'
require 'open-uri'
require 'json'
require 'base64'

puts "Enter the Username"
user = gets
user = user.chomp
puts "Enter the Repo name"
repo = gets
repo = repo.chomp

url = "https://api.github.com/repos/#{user}/#{repo}/readme"
response = open(url).read
data = JSON.parse(response)	
content = Base64.decode64(data["content"])

puts content 
