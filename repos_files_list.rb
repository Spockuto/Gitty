require 'terminal-table'
require 'open-uri'
require 'json'
#To list  all the files of the rep0
#Get the repo recent commit sha
#get the file listing
puts "Enter the Username"
user = gets
user = user.chomp
puts "Enter the Repo name"
repo = gets
repo = repo.chomp

url = "https://api.github.com/repos/#{user}/#{repo}/commits"
response = open(url).read
data = JSON.parse(response)	
sha = data[0]['sha']
row =[]
url ="https://api.github.com/repos/#{user}/#{repo}/git/trees/#{sha}"
response = open(url).read
data = JSON.parse(response)
data['tree'].each do |file|
	size = file['size']
	if(!size)
		size = "dir"
	end
	row << [file['path'] , size]
end
table = Terminal::Table.new :headings =>['File','Size(Bytes)'],:rows => row 
puts table