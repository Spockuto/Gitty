#To archive a given repo

puts "Enter the Username"
user = gets
user = user.chomp
puts "Enter the Repo name"
repo = gets
repo = repo.chomp
url = "https://api.github.com/repos/#{user}/#{repo}/tarball"
system("curl -L #{url} > #{repo}.tar.gz")
puts "File has been saved as #{repo}.tar.gz"