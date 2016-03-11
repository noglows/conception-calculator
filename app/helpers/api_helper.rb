module ApiHelper

  def date_splitter(date)
    split_date = date.split("/")
    month = split_date[0].to_i
    day = split_date[1].to_i
    year = split_date[2].to_i
    return month, day, year
  end

  def create_range(start_date, end_date)
    return (start_date..end_date).map(&:to_s)
  end

  def generate_data_code(year, month, day)
    code = year.to_s
    if month.to_s.length < 2
      code += "0"
    end
    code += month.to_s
    if day.to_s.length < 2
      code += "0"
    end
    code += day.to_s
    return code
  end

  # def range_method(type, start_day, end_day)
  #   respond_to do |format|
  #     format.json do
  #       events = ApiController.helpers.pull_events_in_range(type, start_day, end_day)
  #       render json: events
  #     end
  #   end
  # end

  def get_events(events, dynamo, tableName, year, code)
    start = 0
    still_records = true
    while still_records == true
      params = {
        table_name: tableName,
        key_condition_expression: "#yr = :yyyy and #st = :sort_key",
        expression_attribute_names: {
          "#yr" => "year",
          "#st" => "sort"
        },
        expression_attribute_values: {
          ":yyyy" => year.to_f,
          ":sort_key" => code + start.to_s
        }
      }
      event = dynamo.query(params)
      start += 1
      if event.items == []
        still_records = false
      else
        events.push(event.items)
      end
    end
    return events
  end

  def get_movies_or_songs(events, dynamo, tableName, year, code)
    params = {
      table_name: tableName,
      key_condition_expression: "#yr = :yyyy and #st = :sort_key",
      expression_attribute_names: {
        "#yr" => "year",
        "#st" => "sort"
      },
      expression_attribute_values: {
        ":yyyy" => year.to_f,
        ":sort_key" => code
      }
    }
    result = dynamo.query(params)
    events.push(result.items)
    return events
  end

  def pull_events_in_range(type, start_date, end_date)
    start_month, start_day, start_year = ApiController.helpers.date_splitter(start_date)
    end_month, end_day, end_year = ApiController.helpers.date_splitter(end_date)

    start_date = Date.new(start_year, start_month, start_day)
    end_date = Date.new(end_year, end_month, end_day)
    date_range = ApiController.helpers.create_range(start_date, end_date)

    dynamodb = Aws::DynamoDB::Client.new
    tableName = "XMYS_#{type.capitalize}s"

    events = []
    date_range.each do |date|
      date_comp = date.split("-")

      year = date_comp[0].to_i
      month = date_comp[1].to_i
      day = date_comp[2].to_i

      code = ApiController.helpers.generate_data_code(year, month, day)

      if type == Event || type.capitalize == "Event"
        events = ApiController.helpers.get_events(events, dynamodb, tableName, year, code)
      else
        events = ApiController.helpers.get_movies_or_songs(events, dynamodb, tableName, year, code)
      end
    end
    return events.flatten!
  end

  def single_day_event(type, date)
    month, day, year = ApiController.helpers.date_splitter(date)
    dynamodb = Aws::DynamoDB::Client.new
    table_name = "XMYS_#{type.capitalize}s"
    code = year.to_s
    if month.to_s.length < 2
      code += "0"
    end
    code += month.to_s
    if day.to_s.length < 2
      code += "0"
    end
    code += day.to_s
    if type == "event"
      start = 0
      events = []
      still_records = true
      while still_records == true
        params = {
          table_name: table_name,
          key_condition_expression: "#yr = :yyyy and #st = :sort_key",
          expression_attribute_names: {
            "#yr" => "year",
            "#st" => "sort"
          },
          expression_attribute_values: {
            ":yyyy" => year.to_f,
            ":sort_key" => code + start.to_s
          }
        }
        event = dynamodb.query(params)
        start += 1
        if event.items == []
          still_records = false
        else
          events.push(event.items)
        end
      end
      return events.flatten!
    else
      params = {
        table_name: table_name,
        key_condition_expression: "#yr = :yyyy and #st = :sort_key",
        expression_attribute_names: {
          "#yr" => "year",
          "#st" => "sort"
        },
        expression_attribute_values: {
          ":yyyy" => year.to_f,
          ":sort_key" => code
        }
      }
      event = dynamodb.query(params)
      return event
    end
  end
end
