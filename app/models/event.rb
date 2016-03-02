class Event
  include Dynamoid::Document
  field :year, :integer
  field :month, :integer
  field :day, :integer
  field :info, :string
  field :on_going, :boolean
  field :is_range, :boolean
  field :end_month, :string
  field :end_day, :string
end
