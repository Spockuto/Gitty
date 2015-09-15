require 'github_api'
require 'terminal-table'

#To archive a given repo
#sha required

puts "Enter the Username"
user = gets
user = user.chomp
puts "Enter the Repo name"
repo = gets
repo = repo.chomp

response =  Github.repos.contents.archive user , repo
link =  response.headers.location
system("wget #{link}")
puts "File has been saved as master. File Format: gzip")