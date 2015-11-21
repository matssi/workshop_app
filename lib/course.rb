require 'sinatra/base'
require 'padrino-helpers'

class Course
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text

end
