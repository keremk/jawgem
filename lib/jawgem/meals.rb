require 'faraday'

module Jawgem
  module Meals
    def meals(opts)
      get_collection("/users/#{@user_id}/meals", params_from_time_data(opts))
    end

    def meal_details(meal_xid) 
      get("/meals/#{meal_xid}")
    end

    def create_meal(meal_info, location, meal_items = [])
      post("/users/#{@user_id}/meals", params(meal_info, location, meal_items))
    end

    def update_meal(meal_xid, meal_info, location, meal_items = [])
      post("/meals/#{meal_xid}/partialUpdate", params(meal_info, location, meal_items))
    end

    def delete_meal(meal_xid)
      delete("/meals/#{meal_xid}")
    end

    private
    def params(meal_info, location, meal_items)
      params = {}
      params.merge!(params_from_common_info(meal_info))
      params.merge!(params_from_meal_info(meal_info))
      params.merge!(params_from_location_data(location))
      params.merge!({items: meal_items})
      params
    end

    def params_from_meal_info(meal_info)
      params = {}
      if meal_info[:meal_image_path]
        image_path = meal_info[:meal_image_path]
        file_type = meal_info[:meal_image_file_type] || 'image/jpeg'
        params[:photo] = Faraday::UploadIO.new(image_path, file_type)
      end
      params[:time_created] = date_to_int(meal_info[:time_created]) if meal_info[:time_created]
      params
    end
  end
end