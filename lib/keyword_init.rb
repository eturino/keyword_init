require "keyword_init/version"

module KeywordInit
  def initialize(properties = {})
    properties.each do |k, v|
      normal_setter = "#{k}="
      send normal_setter, v if respond_to? normal_setter
    end
  end
end
