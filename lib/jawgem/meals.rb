module Jawgem
  module Meals
    def meals(opts)
      get_collection("/users/#{@user_id}/meals", params_from_time_data(opts))
    end

    def meal_details(meal_xid) 
      get("/meals/#{meal_xid}")
    end

  end
end