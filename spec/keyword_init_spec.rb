require 'spec_helper'

RSpec.shared_examples "works in relaxed mode" do
  let(:expected_data) { { :attrib => 1, :writeonly => 2, :readonly => nil } }
  let(:empty_data) { { :attrib => nil, :writeonly => nil, :readonly => nil } }

  context '#initialize method' do
    it 'accepts keyword parameters (ignores read-only attributes or any given attribute with no setter)' do
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

    it 'does nothing if nil passed' do
      a = described_class.new nil
      expect(a.my_data).to eq empty_data
    end
  end

  context '#_set_properties method (private)' do
    subject { described_class.new }

    it 'sets the correct values (after creation) in the subject, in the same way of the initialize method' do
      subject.send :_set_properties, :attrib => 1, :writeonly => 2, :readonly => 3
      expect(subject.my_data).to eq expected_data
    end

    it 'does nothing if nil passed' do
      subject.send :_set_properties, nil
      expect(subject.my_data).to eq empty_data
    end
  end
end

RSpec.describe KeywordInit do
  context 'normal behaviour (including KeywordInit)' do
    class TestKlassWithPublicSetters
      include KeywordInit

      attr_accessor :attrib
      attr_writer :writeonly
      attr_reader :readonly

      def my_data
        { :attrib => @attrib, :writeonly => @writeonly, :readonly => @readonly }
      end
    end

    describe TestKlassWithPublicSetters do
      it_behaves_like "works in relaxed mode"
    end
  end

  context 'normal behaviour (including KeywordInit::Relaxed)' do
    describe KeywordInit::Relaxed do
      class TestKlassWithPublicSetters
        include KeywordInit::Relaxed

        attr_accessor :attrib
        attr_writer :writeonly
        attr_reader :readonly

        def my_data
          { :attrib => @attrib, :writeonly => @writeonly, :readonly => @readonly }
        end
      end

      describe TestKlassWithPublicSetters do
        it_behaves_like "works in relaxed mode"
      end
    end
  end

  context 'strict behaviour (KeywordInit::Strict)' do
    describe KeywordInit::Strict do
      class TestStrictKlassWithPublicSetters
        include KeywordInit::Strict

        attr_accessor :attrib
        attr_writer :writeonly
        attr_reader :readonly

        def my_data
          { :attrib => @attrib, :writeonly => @writeonly, :readonly => @readonly }
        end
      end

      describe TestStrictKlassWithPublicSetters do
        let(:expected_data) { { :attrib => 1, :writeonly => 2, :readonly => nil } }
        let(:empty_data) { { :attrib => nil, :writeonly => nil, :readonly => nil } }

        context '#initialize method' do
          it 'accepts keyword parameters (ignores read-only attributes or any given attribute with no setter)' do
            expect { described_class.new :attrib => 1, :writeonly => 2 }.not_to raise_error
          end

          it 'accepts keyword parameters (raises KeywordInit::KeyError if it receives read-only attributes or any given attribute with no setter)' do
            expect { described_class.new :attrib => 1, :writeonly => 2, :readonly => 3 }.to raise_exception(KeywordInit::KeyError)
            expect { described_class.new :attrib => 1, :writeonly => 2, :blaaah => 3 }.to raise_exception(KeywordInit::KeyError)
          end

          it 'executes the setter of each recognised keyword' do
            expect_any_instance_of(described_class).to receive(:attrib=).with(1)
            expect_any_instance_of(described_class).to receive(:writeonly=).with(2)
            described_class.new :attrib => 1, :writeonly => 2
          end

          it 'sets the correct values' do
            a = described_class.new :attrib => 1, :writeonly => 2
            expect(a.my_data).to eq expected_data
          end

          it 'does nothing if nil passed' do
            a = described_class.new nil
            expect(a.my_data).to eq empty_data
          end
        end

        context '#_set_properties method (private)' do
          subject { described_class.new }

          it 'sets the correct values (after creation) in the subject, in the same way of the initialize method' do
            subject.send :_set_properties, :attrib => 1, :writeonly => 2
            expect(subject.my_data).to eq expected_data
          end

          it 'does nothing if nil passed' do
            subject.send :_set_properties, nil
            expect(subject.my_data).to eq empty_data
          end
        end
      end
    end
  end
end