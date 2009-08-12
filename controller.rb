require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-aggregates'
require 'dm-validations'

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
    
  # Renders JS to ask user if they really want to delete  
  def onclick_delete(msg='Are you sure?')
    "if (confirm('#{msg}')) { var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var m = document.createElement('input'); m.setAttribute('type', 'hidden'); m.setAttribute('name', '_method'); m.setAttribute('value', 'delete'); f.appendChild(m);f.submit(); };return false;"
  end
    
end

######################
# Define application actions below make sure to use a get/post/put
# define your erb views in the /views directory
######################

get "/" do
   erb :index
end

##################
# CRUD for 'Example' model
##################
get "/examples" do
  @examples = Example.all
  erb :'/examples/index'
end

get "/examples/new" do
  @example = Example.new
  erb :'/examples/new'
end

post "/examples" do
  @example = Example.new(params[:example])
  if @example.save    
    redirect "/examples"
  else
    erb :'/examples/new'
  end
end

delete '/examples/:id' do
  @example = Example.get(params[:id])
  @example.destroy  
  redirect '/examples'  
end

get "/examples/:id/edit" do
  @example = Example.get(params[:id])
  erb :'/examples/edit'
end

put "/examples/:id" do
  @example = Example.get(params[:id])
  @example.attributes = params[:example]  
  if @example.save    
    redirect '/examples'
  else
    erb :'/examples/edit'
  end
end
