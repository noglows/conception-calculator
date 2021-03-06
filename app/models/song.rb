class Song
  # include Mongoid::Document
  # field :year, type: Integer
  # field :month, type: Integer
  # field :day, type: Integer
  # field :title, type: String
  # field :artist, type: String
  include Dynamoid::Document
  table :name => :Songs
  field :year, :integer
  field :month, :integer
  field :day, :integer
  field :title, :string
  field :artist, :string
end
