require_relative '../lib/loader.rb'

describe Loader::Indentation do
  let(:name) { Loader::Indentation.new(2) }
  let(:line) { 'something' }
  let(:f_line) { '  some' }

  describe '.check' do
    it 'return true if the indentation is eql with the value provided' do
      expect(name.check(line, [])).to be true
    end

    it 'return false no eql with indentation' do
      expect(name.check(f_line, [])).to be false
    end
  end

  describe '.name' do
    it 'return the styled name of the class' do
      expect(name.name).to eql('Style/Indentation')
    end

    it 'must not be empty' do
      expect(name.name).not_to be_empty
    end
  end
end
