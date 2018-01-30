require "keyword_init/version"

module KeywordInit
  def self.included(mod)
    # if using the general KeywordInit module, use the Relaxed
    mod.send(:include, Relaxed)
  end

  module Common
    def initialize(properties = {})
      _set_properties(properties || {})
    end

    def self.normal_setter(k)
      "#{k}="
    end
  end

  module Relaxed
    def self.included(mod)
      mod.send(:include, Common)
    end

    private
    def _set_properties(properties)
      return unless properties
      properties.each do |k, v|
        normal_setter = Common.normal_setter(k)
        send normal_setter, v if respond_to? normal_setter, true
      end
    end
  end

  module Strict
    def self.included(mod)
      mod.send(:include, Common)
    end

    private
    def _set_properties(properties)
      return unless properties
      properties.each do |k, v|
        normal_setter = Common.normal_setter(k)
        raise KeyError.new("no setter recognised for #{k}") unless respond_to? normal_setter, true
        send normal_setter, v
      end
    end
  end

  class KeyError < ::KeyError
  end
end
