require 'github_api'
require 'terminal-table'

#To list  all the files of the rep0
#Get the repo recent commit sha
#get the file listing
puts "Enter the Username"
user = gets
user = user.chomp
puts "Enter the Repo name"
repo = gets
repo = repo.chomp

data = Github.repos.commits.list user , repo
sha = data[0]['sha']
row =[]
Github.git_data.trees.get user , repo , sha do |file|
	size = file['size']
	if(!size)
		size = "dir"
	end
	row << [file.path , size]
end
table = Terminal::Table.new :headings =>['File','Size(Bytes)'],:rows => row 
puts table