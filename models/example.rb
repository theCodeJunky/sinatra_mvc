######################
# This is an example model.
# Find info on Datamapper at: http://datamapper.org/doku.php?id=docs
######################
class Example
  include DataMapper::Resource
  property :id, Serial
  property :name, String
end