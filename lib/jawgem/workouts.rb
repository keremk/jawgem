module Jawgem
  module Workouts
    # WORKOUT_TYPES = {
    #   walk: 1,
    #   run: 2,
    #   lift_weights: 3, 
    #   4  cross_train
    #   5  nike_training
    #   6  yoga
    #   7  pilates
    #   8  body weight exercise **
    #   9  crossfit **
    #   10   p90x **
    #   11   zumba **
    #   12   trx **
    #   13   swim
    #   14   bike
    #   15   elliptical
    #   16   bar method **
    #   17   kinect exercises **
    #   18   tennis
    #   19   basketball
    #   20   golf **
    #   21   soccer
    #   22   ski snowboard
    #   23   dance
    #   24   hike
    #   25   cross country skiing
    #   26   stationary bike
    #   27   cardio
    #   28   game
    # }
    def workouts(opts)
      get_collection("/users/#{@user_id}/workouts", params_from_time_data(opts))
    end

    def workout_details(workout_xid) 
      get("/workouts/#{workout_xid}")
    end

    def workout_intensity(workout_xid)
      get("/workouts/#{workout_xid}/snapshot")
    end

    def create_workout(opts)
      raise Jawgem::MissingParameterError, "time_created or time_completed is missing." if opts[:time_created].nil? || opts[:time_completed].nil?
      params = {}
      params[:time_created] = opts[:time_created].to_i
      params[:time_completed] = opts[:time_completed].to_i
      post("/users/#{@user_id}/workouts", params)
    end
  end
end