require 'oauth2'
require 'jawgem/client'

module Jawgem
  # Recursively turns arrays and hashes into symbol-key based
  # structures.
  #
  # @param [Array, Hash] The structure to symbolize keys for
  # @return A new structure with the keys symbolized
  def self.symbolize_keys(obj)
    case obj
    when Array
      obj.inject([]){|res, val|
        res << case val
        when Hash, Array
          symbolize_keys(val)
        else
          val
        end
        res
      }
    when Hash
      obj.inject({}){|res, (key, val)|
        nkey = case key
        when String
          key.to_sym
        else
          key
        end
        nval = case val
        when Hash, Array
          symbolize_keys(val)
        else
          val
        end
        res[nkey] = nval
        res
      }
    else
      obj
    end
  end
end
