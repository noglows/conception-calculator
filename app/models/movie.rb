class Movie
  include Mongoid::Document
  field :year, type: Integer
  field :month, type: Integer
  field :day, type: Integer
  field :title, type: String
  field :earned, type: Integer
end
