# Running this file:
# $ ruby ./db/migrate.rb
# will create the tables for your project, you must have a database already created
# and defined in the DataMapper.setup below
# Alternatively setup looks like:
# DataMapper.setup(:default, {
#   :adapter  => 'mysql',
#   :host     => 'localhost',
#   :username => 'user' ,
#   :password => 'pass',
#   :database => 'db_name'
# })    
require 'rubygems'
require 'dm-core'
require 'dm-aggregates'

DataMapper.setup(:default, 'mysql://localhost/db_dev')  

# require models:
Dir.glob("#{File.expand_path(File.dirname(__FILE__))}/../models/*.rb").each do |f|
  require f
end

# This creates  your tables
DataMapper.auto_upgrade!

# This creates 5 sample items.
5.times do |item|
  Example.create(:name=>"Thing #{item}")
end