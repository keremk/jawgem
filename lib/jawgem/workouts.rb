module Jawgem
  module Workouts
    WALK = 1
    RUN = 2
    LIFT_WEIGHTS = 3
    CROSS_TRAIN = 4
    NIKE_TRAINING = 5
    YOGA = 6
    PILATES = 7
    BODY_WEIGHT_EXERCISE = 8
    CROSSFIT = 9
    P90X = 10
    ZUMBA = 11
    TRX = 12
    SWIM = 13
    BIKE = 14
    ELLIPTICAL = 15
    BAR_METHOD = 16
    KINECT_EXERCISES = 17
    TENNIS = 18
    BASKETBALL = 19
    GOLF = 20
    SOCCER = 21
    SKI_SNOWBOARD = 22
    DANCE = 23
    HIKE = 24
    CROSS_COUNTRY_SKIING = 25
    STATIONARY_BIKE = 26
    CARDIO = 27
    GAME = 28

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
      post("/users/#{@user_id}/workouts", params(opts))
    end

    def update_workout(xid, opts)
      # Update is a post, instead of a put based on Jawbone API documentation.
      # https://jawbone.com/up/developer/endpoints/workouts
      post("/workouts/#{xid}/partialUpdate", params(opts))
    end

    def delete_workout(xid)
      delete("/workouts/#{xid}")
    end

    private
    def params(opts)
      params = {}
      params.merge!(params_from_time_data(opts))
      params.merge!(params_from_workout(opts))
      params
    end

    def params_from_workout(opts)
      params = {}
      params[:sub_type] = opts[:workout_type]
      params[:calories] = opts[:calories] if opts[:calories]
      params[:image_url] = opts[:image_url] if opts[:image_url]
      params[:intensity] = opts[:intensity] if opts[:intensity]
      params
    end
  end
end