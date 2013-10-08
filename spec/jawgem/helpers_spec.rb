require 'spec_helper'

module Jawgem
  class Test
    include Helpers
  end

  describe "Helpers" do 
    before :each do 
      @date = Time.now
      @yesterday = Time.now - 1.days
    end

    it 'creates date param only if date param exists' do 
      opts = { date: @date }
      params = Test.new.params_from_time_data(opts)
      params[:date].should == @date.strftime("%Y%m%d").to_i

      opts = {}
      params = Test.new.params_from_time_data(opts)
      params[:date].should be_nil
    end

    it 'creates end_time if start_time is provided as the end of today or date provided' do 
      opts = { start_time: @yesterday, date: @date }
      params = Test.new.params_from_time_data(opts)
      params[:date].should == @date.strftime("%Y%m%d").to_i    
      params[:start_time].should == @yesterday.to_i
      params[:end_time].should == @date.end_of_day.to_i
    end 

    it 'creates parameters for the location data' do 
      opts = { lat: 37.793507, lon: -122.422719, name: "Fooland", accuracy: 10 }
      params = Test.new.params_from_location_data(opts)
      params[:place_lat].should == 37.793507
      params[:place_lon].should == -122.422719
      params[:place_name].should == "Fooland"
      params[:place_acc].should == 10.0
    end
    
  end
end