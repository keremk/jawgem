module Jawgem
  module Sleeps
    def sleeps(opts)
      get_collection("/users/#{@user_id}/sleeps", params_from_time_data(opts))
    end

    def sleep_details(sleep_xid) 
      get("/sleeps/#{sleep_xid}")
    end

    def sleep_phases(sleep_xid)
      get("/sleeps/#{sleep_xid}/snapshot")
    end

    def create_sleep(opts)
      raise Jawgem::MissingParameterError, "time_created or time_completed is missing." if opts[:time_created].nil? || opts[:time_completed].nil?
      post("/users/#{@user_id}/sleeps", params_from_time_data(opts))
    end
  end
end