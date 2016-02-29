module ApiHelper
  
  def date_splitter(date)
    split_date = date.split("/")
    month = split_date[0].to_i
    day = split_date[1].to_i
    year = split_date[2].to_i
    return month, day, year
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

  def create_range(start_date, end_date)
    return (start_date..end_date).map(&:to_s)
  end

end
