class Event
  # include Mongoid::Document
  # field :year, type: Integer
  # field :month, type: Integer
  # field :day, type: Integer
  # field :info, type: String
  # field :on_going, type: Boolean
  # field :is_range, type: Boolean
  # field :end_month, type: String
  # field :end_day, type: String
  include Dynamoid::Document
  table :name => :Events
  field :year, :integer
  field :month, :integer
  field :day, :integer
  field :info, :string
  field :on_going, :boolean
  field :is_range, :boolean
  field :end_month, :string
  field :end_day, :string

end
