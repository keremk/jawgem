require 'active_support/time'

module Jawgem
  module Moves
    def moves(opts)
      get_collection("/users/#{@user_id}/moves", params_from_time_data(opts))
    end

    def move_details(move_xid) 
      get("/moves/#{move_xid}")
    end

    def move_intensity(move_xid)
      get("/moves/#{move_xid}/snapshot")
    end
  end
end