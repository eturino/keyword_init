require 'spec_helper'

RSpec.shared_examples "works" do
  let(:expected_data) { {:attrib => 1, :writeonly => 2, :readonly => nil} }

  context 'initialize method' do
    it 'accepts keyword parameters' do
      expect { described_class.new :attrib => 1, :writeonly => 2, :readonly => 3 }.not_to raise_error
    end

    it 'executes the setter of each recognised keyword' do
      expect_any_instance_of(described_class).to receive(:attrib=).with(1)
      expect_any_instance_of(described_class).to receive(:writeonly=).with(2)
      described_class.new :attrib => 1, :writeonly => 2, :readonly => 3
    end

    it 'sets the correct values' do
      a = described_class.new :attrib => 1, :writeonly => 2, :readonly => 3
      expect(a.my_data).to eq expected_data
    end
  end
end


RSpec.describe KeywordInit do
  class TestKlassWithPublicSetters
    include KeywordInit

    attr_accessor :attrib
    attr_writer :writeonly
    attr_reader :readonly

    def my_data
      {:attrib => @attrib, :writeonly => @writeonly, :readonly => @readonly}
    end
  end

  describe TestKlassWithPublicSetters do
    it_behaves_like "works"
  end

  class TestKlassWithPublicSetters
    include KeywordInit

    attr_accessor :attrib
    attr_writer :writeonly
    attr_reader :readonly

    def my_data
      {:attrib => @attrib, :writeonly => @writeonly, :readonly => @readonly}
    end
  end

  describe TestKlassWithPublicSetters do
    it_behaves_like "works"
  end
end