require 'optparse'
require 'net/http'
require 'uri'

options = {}
options[:uri] = "none"
options[:contains] = "none"
options_parser = OptionParser.new do |opts|
  opts.banner = "Usage: uri-check.rb [options]"

  opts.on("-u", "--uri <uri>", "Enter the location you wish to check") do |uri|
  	options[:uri] = uri
  end

  opts.on("-c", "--contains <contains>", "Enter the text the uri should contain") do |contains|
    options[:contains]    = contains
  end

end

options_parser.parse!

if options[:uri] == "none" || options[:contains] == "none"
  puts "Please define a uri and the text that a successful check should display"
  exit(1)
end

results = Net::HTTP.get(URI.parse(options[:uri]))

if results.include? options[:contains]
  puts "content found"
  exit(0)
else
  puts "content not found"
  puts results
  exit(1)
end
