module ApplicationHelper
  def display_station_name(abbreviation)
    Station.find_by_abbr(abbreviation).name
  end


  def remove_seconds_from_time(time)
    time.change(:sec => 0)
  end

  def number_to_minutes(number)
    number.to_i.minutes
  end

  def format_time_and_date(date_time)
    date_time.strftime("%l:%M %P on %B %d")
  end


  def format_time(time)
    time.strftime("%l:%M %P")
  end
end
