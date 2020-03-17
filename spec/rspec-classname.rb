require_relative '../lib/loader.rb'

describe Loader::ClassName do
    let(:f_name) { Loader::ClassName.new(false) }
    let(:name) { Loader::ClassName.new(true) }
    let(:line) { 'class Someclass {' }
    let(:f_line) { 'class some {' }

    describe '.check' do
        it 'return true when is deactivated from configuration file' do 
            expect(f_name.check('',[])).to be true
        end

        it 'return true if class name is Capitalize' do
            expect(name.check(line,[])).to be true
        end

        it 'return false if class name is not capitalize' do
            expect(name.check(f_line,[])).not_to be true
        end
    end

    describe '.name' do
        it 'return the styled name of the class' do
            expect(name.name).to eql('Style/ClassName')
        end

        it 'must not be empty' do
            expect(name.name).not_to be_empty
        end
    end
end