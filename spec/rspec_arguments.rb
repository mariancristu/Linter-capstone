require_relative '../lib/arguments.rb'

describe Arguments do
  let(:arg) { Arguments.new(%w[all]) }
  let(:no_arg) { Arguments.new(%w[]) }

  describe '.check_arguments' do
    it 'returns true when finish executing' do
      expect(arg.check_arguments).to be true
    end

    it 'raise a ArgumentError with no arg' do
      expect(-> { no_arg.check_arguments }).to raise_error ArgumentError
    end
  end
end
