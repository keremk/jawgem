module Jawgem
  module Body
    def body_measurements(opts)
      get_collection("/users/#{@user_id}/body_events", params_from_time_data(opts))
    end

    def body_measurement_details(xid)
      get("/body_events/#{xid}")
    end

    def create_body_measurement(opts)
      post("/users/#{@user_id}/body_events", params(opts))
    end

    def delete_body_measurement(xid)
      delete("/body_events/#{xid}")
    end

    private 
    def params(opts)
      params = {}
      params.merge!(params_from_common_info(opts))
      params.merge!(params_from_body_metrics(opts))
      params
    end

    def params_from_body_metrics(opts)
      params = {}
      params[:weight] = opts[:weight].to_i if opts[:weight]
      params[:body_fat] = opts[:body_fat_percentage].to_i if opts[:body_fat_percentage]
      params[:lean_mass] = opts[:lean_mass_percentage].to_i if opts[:lean_mass_percentage]
      params[:bmi] = opts[:bmi].to_i if opts[:bmi]
      params
    end
  end
end