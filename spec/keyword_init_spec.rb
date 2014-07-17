require 'spec_helper'

RSpec.describe KeywordInit do
  class TestKlass
    include KeywordInit

    attr_accessor :attrib
    attr_writer :writeonly
    attr_reader :readonly

    def my_data
      {attrib: attrib, writeonly: writeonly, readonly: readonly}
    end
  end

  context 'initialize method' do
    it 'accepts keyword parameters' do
      expect { TestKlass.new attrib: 1, writeonly: 2, readonly: 3 }.not_to raise_error
    end

    it 'executes the setter of each recognised keyword' do
      expect_any_instance_of(TestKlass).to receive(:attrib=).with(1)
      expect_any_instance_of(TestKlass).to receive(:writeonly=).with(2)
      TestKlass.new attrib: 1, writeonly: 2, readonly: 3
    end
  end
end