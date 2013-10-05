require 'spec_helper'

module Jawgem
  describe Client do 
    before :each do
      @client = Jawgem::Client.new({
        client_id: "CC1233Adfg",
        app_secret: "4ebd5a005f7d5bdd20ca8245e214c0f86efdd351",
        access_token: "adaderSFjlkjaldsjlkjflwefirwjl"
      })
    end

    it 'defaults to the user_id @me, which is the user with access_token' do
      @client.user_id.should == '@me'
    end

    describe 'single item return' do 
      before :each do 
        ::OAuth2::AccessToken.any_instance.stub(:get) do |path, params|
          object = OpenStruct.new
          object.response = OpenStruct.new
          object.response.body = {
            meta: {
              user_xid: "b9yCLa3f01yf",
              message: "OK",
              code: 200
            },
            data:{
              xid: "akasdasd",
              first: "Jack",
              last: "Bauer",
              image: "http://images2.fanpop.com/images/photos/4400000/Jack-Bauer-wallpapers-jack-bauer-4443494-1024-768.jpg"
            }
          }.to_json
          object
        end
      end

      it 'gets the response array for an item' do 
        data, meta = @client.get("/foo/bar")
        data[:first].should == "Jack"
        meta[:user_xid].should == "b9yCLa3f01yf"
      end
    end

    describe 'collection return' do 
      before :each do 
        ::OAuth2::AccessToken.any_instance.stub(:get) do |path, params|
          object = OpenStruct.new
          object.response = OpenStruct.new
          object.response.body = {
            meta: {
              user_xid: "b9yCLa3f01yf",
              message: "OK",
              code: 200
            },
            data:{
              data: [ {}, {} ],
              size: 2,
              links: {
                "next" => "https://api.example.com/resource?p=4",
                "prev" => "https://api.example.com/resource?p=2"
              }
            }
          }.to_json
          object
        end
      end

      it 'gets the response array for a collection' do 
        data, meta = @client.get_collection("/foo/bar")
        data.class.should == Collection
        data.items.length.should == 2
        data.size.should == 2
      end
    end
  end
end
