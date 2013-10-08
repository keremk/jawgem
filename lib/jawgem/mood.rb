module Jawgem
  module Mood
    UNKNOWN = 0
    ULTRA_ENERGIZED = 1
    ENERGIZED = 2
    GOOD = 3
    JUST_OK = 4
    UNHAPPY = 5
    MISERABLE = 6
    ULTRA_MISERABLE = 7
    FEELING_FINE = 8

    def mood(opts)
      get("/users/#{@user_id}/mood", params_from_time_data(opts))
    end

    def record_mood(opts)
      raise Jawgem::MissingParameterError, "Missing mood parameter" if opts[:mood].nil?
      post("/users/#{@user_id}/mood", params_from_mood_info(opts))
    end

    def mood_details(xid)
      get("/mood/#{xid}")
    end

    def delete_mood(xid)
      delete("/mood/#{xid}")
    end

    private 
    def params_from_mood_info(mood_info)
      params = {}
      params[:title] = mood_info[:title] if mood_info[:title]
      params[:sub_type] = mood_info[:mood]
      params
    end
  end
end