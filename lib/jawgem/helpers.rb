module Jawgem
  module Helpers
    def date_to_int(date)
      date.strftime("%Y%m%d").to_i
    end

    def seconds_to_range_duration(seconds)
      [seconds/3600, "d"]
    end
  end
end