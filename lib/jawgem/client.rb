require 'jawgem/version'
require 'jawgem/profile'
require 'jawgem/moves'
require 'jawgem/sleeps'
require 'jawgem/workouts'
require 'jawgem/mood'
require 'jawgem/cardiac'
require 'jawgem/meals'
require 'jawgem/body'
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
    include Workouts
    include Meals
    include Cardiac
    include Mood
    include Body

    attr_accessor :user_id 

    # Initializes the Jawgem client.
    #
    # @param [Hash] opts options to initialize client with.
    # @option opts [String] :client_id The client id generated for your Jawbone
    #   app. (Get this from https://jawbone.com/up/developer/ ) 
    # @option opts [String] :app_secret The app secret generated for your Jawbone
    #   app. (Get this from https://jawbone.com/up/developer/ ) 
    # @option opts [String] :access_token This is the access_token that you need to call
    #   the Jawbone APIs with. It is per user and generated after the OAuth2.0 handshake.
    #   Use OmniAuth (https://github.com/ruthienachmany/omniauth-jawbone) to get this.
    # @example 
    #   client = Jawgem::Client.new {
    #     client_id: "KAQe1212",
    #     app_secret: "jshdfjkhfksdhfskjhfkewrwrw",
    #     access_token: "ahdkajsdhkajhrkerwr"          
    #   }
    # @return [Jawgem::Client] the client that is ready to be logged in. The default is 
    #   for the user_id = @me. (I.e. the user with the access_token.)
    def initialize(opts)
      @client_id = opts[:client_id]
      @app_secret = opts[:app_secret]
      @access_token = opts[:access_token]
      @site = 'https://jawbone.com'
      @prefix = '/nudge/api/v.1.0'
      @user_id = '@me'
    end

    # Does a get request to Jawbone UP API, and returns the response body for a single item.
    # This API is by the higher order calls, so it is not recommended to use this directly, 
    # if there is an already existing Ruby wrapper for the endpoint.
    # 
    # @param [String] path The path will be prepended by https://jawbone.com/nudge/api/v.1.0, specify 
    #   it, starting with / (E.g. /users) 
    # @param [Hash] params Optional hash or parameters for the Get request
    # @return [Array] 2 element array. First element is the data, second element is the metadata.
    def get(path, params = {})
      parse_item access_token.get("#{@prefix}/#{path}", params)
    end


    def get_collection(path, params = {}, full_path=false)
      path = "#{@prefix}/#{path}" unless full_path
      parse_collection access_token.get(path, params)
    end

    def post(path, content = {})
      parse_item access_token.post("#{@prefix}#{path}", 
        { params: content, 
          headers: { 'Content-Type' => 'application/x-www-form-urlencoded'}
        })
    end

    def delete(path) 
      parse_item access_token.delete("#{@prefix}#{path}")
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

  end
end