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

  def create_range(start_date, end_date)
    start_month, start_day, start_year = ApiController.helpers.date_splitter(start_date)
    end_month, end_day, end_year = ApiController.helpers.date_splitter(end_date)
    days_in_month = {"January" => 31, "February" => 28, "March" => 31, "April" => 30, "May" => 31, "June" => 30, "July" => 31, "August" => 31, "September" => 30, "October" => 31 }
    days_in_month["November"] = 30
    days_in_month["December"] = 31
  end

  def check_leap_year(year)
    if year % 4 != 0
      return false
    elsif year % 100 !=0
      return true
    elsif year % 400 != 0
      return false
    else
      return true
    end
  end
end
