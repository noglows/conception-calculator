class Movie
  include Mongoid::Document
  field :year, type: Integer
  field :month, type: Integer
  field :day, type: Integer
  field :title, type: String

  # include Dynamoid::Document
  # table :name => :Movies
  # field :year, :integer
  # field :month, :integer
  # field :day, :integer
  # field :title, :string

end
