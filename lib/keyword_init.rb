require "keyword_init/version"

module KeywordInit
  def initialize(properties = {})
    _set_properties properties
  end

  private
  def _set_properties(properties)
    properties.each do |k, v|
      normal_setter = "#{k}="
      send normal_setter, v if respond_to? normal_setter, true
    end
  end
end
