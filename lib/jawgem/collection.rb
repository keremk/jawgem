module Jawgem
  class Collection 
    def initialize(data, client)
      @data = data
      @client = client
    end

    def items
      @data[:data] || @data[:items]
    end

    def size 
      @data[:size] || 0
    end

    def next
      return nil if @data.nil? || @data[:links].nil? || @data[:links][:next].nil?
      full_path, params = split_params(@data[:links][:next])
      @client.get_collection(full_path, params, true)
    end

    def prev
      return nil if @data.nil? || @data[:links].nil? || @data[:links][:prev].nil?
      full_path, params = split_params(@data[:links][:prev])
      @client.get_collection(full_path, params, true)
    end

    private 
    def split_params(path)
      path, params_string = path.split('?')
      params = params_string.split('&').reduce({}) do |memo, param| 
        name, value = param.split('=')
        memo[name] = value
        memo
      end
      [path, params]
    end
  end
end