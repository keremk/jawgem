require 'jawgem/version'
require 'jawgem/profile'
require 'jawgem/moves'
require 'jawgem/sleeps'
require 'jawgem/helpers'
require 'jawgem/collection'
require 'jawgem/errors'
require 'json'

module Jawgem
  class Client
    include Helpers
    include Profile
    include Moves
    include Sleeps

    attr_accessor :user_id 

    def initialize(opts)
      @client_id = opts[:client_id]
      @app_secret = opts[:app_secret]
      @access_token = opts[:access_token]
      @site = 'https://jawbone.com'
      @prefix = '/nudge/api/v.1.0'
      @user_id = '@me'
    end


    def get(path, params = {})
      parse_item access_token.get("#{@prefix}/#{path}", params)
    end

    def get_collection(path, params = {}, full_path=false)
      path = "#{@prefix}/#{path}" unless full_path
      parse_collection access_token.get(path, params)
    end

    private 

    def client
      @client ||= ::OAuth2::Client.new(@client_id, @app_secret, { raise_errors: false, site: @site, headers: { 'Content-Type' => 'application/json'} } ) 
    end

    def access_token
      @token ||= ::OAuth2::AccessToken.new(client, @access_token, {})
    end

    def parse_item(result)
      response = parse_response(result)
      [response[:data], response[:meta]]
    end

    def parse_collection(result)
      response = parse_response(result)
      [Collection.new(response[:data], self), response[:meta]]
    end

    def parse_response(result)
      json_response = result.response.body
      response = ::JSON.parse(json_response, symbolize_names: true)
    end

    def params_from_time_data(opts)
      params = {}
      params[:date] = date_to_int(opts[:date]) if opts[:date] 
      params[:start_time] = opts[:start_time].to_i if opts[:start_time]
      if opts[:end_time] 
        params[:end_time] = opts[:end_time].to_i 
      elsif opts[:start_time]
        params[:end_time] = (opts[:date] || Time.now).end_of_day.to_i
      end
      params[:updated_after] = opts[:updated_after].to_i if opts[:end_time]
      params
    end
  end
end