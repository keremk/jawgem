require 'active_support/time'

module Jawgem
  module Profile
    def user_info
      get("/users/#{@user_id}")
    end

    def friends
      get("/users/#{@user_id}/friends")
    end

    def mood(date = nil)
      params = {}
      params[:date] = date_to_int(date) if date
      get("/users/#{@user_id}/mood")
    end

    def trends(opts = {})
      end_date = date_to_int(opts[:end_date] || Time.now )
      range_duration, range = seconds_to_range_duration(opts[:duration] || 3600)
      bucket_size = opts[:bucket_size] || "d"
      params = {
        end_date: end_date,
        range_duration: range_duration,
        range: range,
        bucket_size: bucket_size
      }
      get_collection("/users/#{@user_id}/trends", params)  
    end
  end
end