module ApiHelper
  def date_splitter(date)
    split_date = date.split("/")
    months = {"1" => "January", "2" => "February", "3" => "March", "4" => "April", "5" => "May", "6" => "June", "7" => "July", "8" => "August"}
    months["9"] = "September"
    months["10"] = "October"
    months["11"] = "November"
    months["12"] = "December"
    month = months[split_date[0]]
    day = split_date[1].to_i
    year = split_date[2].to_i
    return month, day, year
  end
end
