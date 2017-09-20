module Holidays
  def self.memorial_day(do_year)
    do_year.weeks.each do | week |
      week.days.reverse_each do | day |
        if days.month == 5 && day.name == 'Mon'
            day.tasks.unshift('[Memorial_Day]')
            binding.pry
            break
        end
      end
    end
    do_year
  end

  def self.easter(do_year)
    year = do_year.year
    epact_calc = ( 24 + 19 * ( year % 19 ) ) % 30
    paschal_days = epact_calc - ( epact_calc / 28 )
    days_to_sunday = paschal_days - (
      ( year + ( year / 4 ) + paschal_days - 13 ) % 7
    )
    easter_month = 3 + ( days_to_sunday + 40 ) / 44
    easter_day = days_to_sunday + 28 - (
      31 * ( easter_month / 4 )
    )
    do_year.weeks.each do | week |
      week.days.each do | day |
        if day.month == easter_month && day.month_day == easter_day
          day.tasks.unshift('[Easter]')
        end
      end
    end
    do_year
  end

  def self.thanksgiving(do_year)
    november_thursdays = []
    november_thursdays_count = 0
    do_year.weeks.each do | week |
      week.days.each do | day |
        if day.month == 11 && day.name == 'Thu'
          november_thursdays_count += 1
          if november_thursdays_count == 4
            day.tasks.unshift('[Thanksgiving]')
          end
        end
      end
    end
  end
end
