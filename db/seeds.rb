# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# puts 'EMPTY THE MONGODB DATABASE'
# ::Mongoid::Sessions.default.drop

File.open("./2014_ready.txt", "r").each do |line|
  a = line.split(", ")
  check = 3
  info = ""
  while (a[check] != "true") && (a[check] != "false")
    info += " "
    info += a[check]
    check += 1
  end
  if a[check] == "true"
    a[check] = true
  elsif a[check] == "false"
    a[check] = false
  end
  if a[check+1] == "true"
    a[check+1] = true
  elsif a[check+1] == "false"
    a[check+1] = false
  end

  a[check+3].slice!("\n")

  event = Event.create! :year => a[0].to_i, :month => a[1], :day => a[2], :info => info, :on_going => a[check], :is_range => a[check+1], :end_month => a[check+2], :end_day => a[check+3]
  puts "New event created: " << event.info
  event.save
end



# game = Game.create! :title => 'First Game', :user_id => user._id, :current_player => user._id
# puts 'New game created: ' << game.title
# user.games.push(game)
# user.save
#
# game2 = Game.create(:title => 'Foo Game', users: [
#   User.create(:name => 'd1', :email => 'd1@example.com', :password => 'd', :password_confirmation => 'd'),
#   User.create(:name => 'd2', :email => 'd2@example.com', :password => 'd', :password_confirmation => 'd'),
#   User.create(:name => 'd3', :email => 'd3@example.com', :password => 'd', :password_confirmation => 'd')
#   ])
# puts 'Second game created: ' << game2.title
