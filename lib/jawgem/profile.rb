require 'active_support/time'

module Jawgem
  module Profile
    def user_info
      get("/users/#{@user_id}")
    end

    def friends
      get("/users/#{@user_id}/friends")
    end

    def trends(opts = {})
      get_collection("/users/#{@user_id}/trends", params)  
    end

    private 
    def params(opts)
      params = {}
      params[:end_date] = date_to_int(opts[:end_date] || Time.now )
      params[:range_duration], params[:range] = seconds_to_range_duration(opts[:duration] || 3600)
      params[:bucket_size] = opts[:bucket_size] || "d"
      params
    end
  end
end