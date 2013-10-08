module Jawgem
  module Helpers
    def date_to_int(date)
      date.strftime("%Y%m%d").to_i
    end

    def seconds_to_range_duration(seconds)
      [seconds/3600, "d"]
    end

    def params_from_time_data(time_data)
      params = {}
      params[:date] = date_to_int(time_data[:date]) if time_data[:date] 
      params[:start_time] = time_data[:start_time].to_i if time_data[:start_time]
      if time_data[:end_time] 
        params[:end_time] = time_data[:end_time].to_i 
      elsif time_data[:start_time]
        params[:end_time] = (time_data[:date] || Time.now).end_of_day.to_i
      end
      params[:updated_after] = time_data[:updated_after].to_i if time_data[:end_time] && time_data[:updated_after]
      params[:time_created] = time_data[:time_created].to_i if time_data[:time_created]
      params[:time_completed] = time_data[:time_completed].to_i if time_data[:time_completed]
      params
    end

    def params_from_location_data(location)
      params = {}
      params[:place_lat] = location[:lat].to_f if location[:lat]
      params[:place_lon] = location[:lon].to_f if location[:lon]
      params[:place_name] = location[:name] if location[:name]
      params[:place_acc] = location[:accuracy].to_f if location[:accuracy]
      params
    end

    def params_from_common_info(common_info)
      params = {}
      params[:photo_url] = common_info[:photo_url] if common_info[:photo_url]
      params[:title] = common_info[:title] if common_info[:title]
      params[:note] = common_info[:note] if common_info[:note]
      params
    end
  end
end