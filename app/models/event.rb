class Event
  include Mongoid::Document
  field :year, type: Integer
  field :month, type: Integer
  field :day, type: Integer
  field :info, type: String
  field :on_going, type: Boolean
  field :is_range, type: Boolean
  field :end_month, type: String
  field :end_day, type: String
end
