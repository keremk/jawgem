module Jawgem
  module Helpers
    def date_to_int(date)
      date.strftime("%Y%m%d").to_i
    end

    def seconds_to_range_duration(seconds)
      [seconds/3600, "d"]
    end

    def params_from_time_data(opts)
      params = {}
      params[:date] = date_to_int(opts[:date]) if opts[:date] 
      params[:start_time] = opts[:start_time].to_i if opts[:start_time]
      if opts[:end_time] 
        params[:end_time] = opts[:end_time].to_i 
      elsif opts[:start_time]
        params[:end_time] = (opts[:date] || Time.now).end_of_day.to_i
      end
      params[:updated_after] = opts[:updated_after].to_i if opts[:end_time] && opts[:updated_after]
      params
    end

  end
end