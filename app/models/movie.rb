class Movie
  include Dynamoid::Document
  field :year, :integer
  field :month, :integer
  field :day, :integer
  field :title, :string
end
