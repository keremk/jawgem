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
  end
end