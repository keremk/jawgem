require 'faraday'

module Jawgem
  module Cardiac
    def cardiac_metrics(opts)
      get_collection("/users/#{@user_id}/cardiac_events", params_from_time_data(opts))
    end

    def cardiac_metric_details(xid) 
      get("/cardiac_events/#{xid}")
    end

    def create_cardiac_metric(opts)
      post("/users/#{@user_id}/meals", params(opts))
    end

    def delete_cardiac_metrics(xid)
      delete("/cardiac_events/#{xid}")
    end

    private
    def params(opts)
      params = {}
      params.merge!(params_from_common_info(opts))
      params.merge!(params_from_cardiac_metrics(opts))
      params
    end

    def params_from_cardiac_metrics(cardiac_metrics)
      params = {}
      params[:heart_rate] = cardiac_metrics[:heart_rate] if cardiac_metrics[:heart_rate]
      params[:systolic_pressure] = cardiac_metrics[:systolic_pressure] if cardiac_metrics[:systolic_pressure]
      params[:diastolic_pressure] = cardiac_metrics[:diastolic_pressure] if cardiac_metrics[:diastolic_pressure]
      params      
    end
  end
end
