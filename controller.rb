require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-aggregates'  

######################
# Define setup CONSTANTS or other items here
######################
configure do
  puts "@@@@calling configure block"
  DEFINE_CONSTANT = 'some constant'
  DataMapper::Logger.new(STDOUT, :debug)
  DataMapper.setup(:default, 'mysql://localhost/db_dev')
  Dir.glob("#{File.expand_path(File.dirname(__FILE__))}/models/*.rb").each do |f|
    puts "@@@@@@@ requiring #{f}"
    require f
  end  
end

######################
# This executes if an exception occurs.
######################
error do
  puts "Exception! #{request.env['sinatra.error']}"
  erb :five_hundred
end

######################
# Put helper methods here, they can be used in the controller or views.
######################
helpers do
  
  # Renders a partial
  def partial(page, options={})
    erb page, options.merge!(:layout => false)
  end
    
end

######################
# Define application actions below make sure to use a get/post
# define your erb views in the /views directory
######################

get "/" do
   erb :index
end

get "/examples" do
  @examples = Example.all
  erb :examples
end