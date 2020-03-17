require_relative '../lib/loader.rb'

describe Loader::MaxLength do
  let(:name) { Loader::MaxLength.new(120) }
  let(:var) { 'something' }
  let(:f_var) { (1..130).map { ('a'..'z').to_a[rand(26)] }.join }

  describe '.check' do
    it 'return true if the line provided is smaller' do
      expect(name.check(var, [])).to be true
    end

    it 'return false if the line is bigger' do
      expect(name.check(f_var, [])).to be false
    end
  end

  describe '.name' do
    it 'return the styled name of the class' do
      expect(name.name).to eql('Style/MaxLength')
    end

    it 'must not be empty' do
      expect(name.name).not_to be_empty
    end
  end
end
