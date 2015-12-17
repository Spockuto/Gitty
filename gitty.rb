require 'terminal-table'
require 'open-uri'
require 'json'
require 'base64'
require 'optparse'

  options = {:repo => nil,:files =>nil,:readme =>nil,:followers =>nil ,:following=>nil,:archive=>nil}
	optparse = OptionParser.new do |opts|
  	opts.banner = "Usage: cli-github [options]"
  	opts.on('-l', '--repo <username>', 'List the repositories of the user') do |repo|
    	options[:repo] = repo
  	end
 
  	opts.on('-f', '--files <username>/<repo>', 'List the files of the Repositories') do |files|
    	options[:files] = files
  	end

  	opts.on('-r', '--readme <username>/<repo>', 'Check the Readme of the Repository') do |readme|
    	options[:readme] = readme
  	end

  	opts.on('-o', '--followers <username>', 'List the followers of the user') do |followers|
    	options[:followers] = followers
  	end

  	opts.on('-i', '--following <username>', 'List the people the user is following') do |following|
    	options[:following] = following
  	end

  	opts.on('-t', '--archive <username>/<repo>', 'Get the tar file of the repository') do |archive|
    	options[:archive] = archive
  	end

  	opts.on('-h', '--help', 'Help') do
    	puts opts
    	exit
 		end
	end

	optparse.parse!

	if(options[:readme])
		user = options[:readme].split('/').first
		repo = options[:readme].split('/').last
		url = "https://api.github.com/repos/#{user}/#{repo}/readme"
		response = open(url).read
		data = JSON.parse(response)	
		content = Base64.decode64(data["content"])
		puts content 
	end

	if(options[:files])
		user = options[:files].split('/').first
		repo = options[:files].split('/').last
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
	end

	if(options[:repo])
		user = options[:repo]
		url = "https://api.github.com/users/#{user}/repos"
		response = open(url).read
		data = JSON.parse(response)	
		row = []
		data.each do |list|
			row << [ list['name']  , list['stargazers_count'] ,list['fork']]
		end
		table = Terminal::Table.new :headings =>['Name','Stars','fork'],:rows => row 
		puts table
	end

	if(options[:archive])
		user = options[:archive].split('/').first
		repo = options[:archive].split('/').last
		url = "https://api.github.com/repos/#{user}/#{repo}/tarball"
		system("curl -L #{url} > #{repo}.tar.gz")
		puts "File has been saved as #{repo}.tar.gz"
	end

	if(options[:followers])
		user = options[:followers]
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
		puts table1
	end

	if(options[:following])
		user = options[:following]
		row = []
		iterator = 1
		url = "https://api.github.com/users/#{user}/following"
		response = open(url).read
		parse = JSON.parse(response)
		parse.each do |name|
			row << [iterator, name["login"]]
			iterator = iterator + 1
		end
		table = Terminal::Table.new :headings =>['Id','Users'] ,:rows => row
		puts table
	end
