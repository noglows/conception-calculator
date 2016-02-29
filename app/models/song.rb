class Song
  include Mongoid::Document
  field :year, type: Integer
  field :month, type: Integer
  field :day, type: Integer
  field :title, type: String
  field :artist, type: String
end
