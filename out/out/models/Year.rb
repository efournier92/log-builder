class Year
  attr_accessor :weeks
  attr_reader :year

  def initialize(year)
    @year  = year
    @weeks = []
    month  = 1
    week_index = 1
    days_in_months = Year.days_in_months
    # adjust for leap year
    days_in_months[2] = 29 if self.leap_year?
    day = Year.get_first_monday(year)

    # TODO: fill in last end weeks

    52.times do
      days_this_week = Week.days_this_week(day, month)
      do_week = Week.new(week_index, days_this_week, month)
      if do_week.week_index.odd?
        do_week.days.find do | day |
          if day.name == 'Sun'
            day.tasks = Day.odd_sunday_tasks 
          end
        end
      end
      @weeks.push(do_week)
      day += 7
      # check if new month
      if day > days_in_months[month - 1]
        day = day - days_in_months[month - 1]
        month += 1
      end
      first_day_of_month = nil
      week_index += 1
    end
  end

  def self.days_in_months
    [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]
  end

  def leap_year?
    @year % 4 == 0 && !( @year % 100 == 0 && @year % 400 != 0 )
  end

  def self.get_first_monday(year)
    years_since = year - 1
    leap_years = years_since / 4
    century_years = years_since / 100
    four_century_years = years_since / 400

    total_leap_years = leap_years - century_years + four_century_years
    total_precesion = years_since + total_leap_years
    day_index = total_precesion % 7

    first_monday = 8 - day_index;

    if first_monday > 7
      first_monday = first_monday - 7
    end
    first_monday
  end

  def self.add_holidays(do_year)
    Holidays.add_all(do_year)
  end

  def self.add_birthdays(do_year)
    Birthdays.add_all(do_year)
  end

end

