require_relative '../lib/loader.rb'

describe Loader do
  let(:loader) { Loader }

  describe '#create_filter' do
    it 'returns an array' do
      expect(loader.create_linters).to be_instance_of(Array)
    end

    it 'expect the array returned not to be empty' do
      expect(loader.create_linters).not_to be_empty
    end

    context 'fake return from filter_classes private method' do
      before do
        allow(Loader).to receive(:filter_classes).and_return(nil)
      end

      it 'expects to raise an NoMethodError error' do
        expect(-> { loader.create_linters }).to raise_error NoMethodError
      end
    end
  end
end
