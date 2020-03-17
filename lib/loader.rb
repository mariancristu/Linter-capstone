require_relative '../lintermodules/modulespec.rb'
Dir['lintermodules/*.rb'].each { |file| require_relative "../lintermodules/#{File.basename(file)}" }
require 'yaml'

module Loader
  @all_classes = []
  @yaml_config = []
  private_class_method def self.all_classes
    @all_classes = Loader.constants.select { |c| Loader.const_get(c).is_a? Class }
  end

  private_class_method def self.filter_classes
    all_classes
    @yaml_config = YAML.load(File.read('jslint.yml'))
    @all_classes.select do |c|
      @yaml_config.key?(c)
    end
  end

  def self.create_linters
    filter = filter_classes
    filter.map do |x|
      Loader.const_get(x).new(@yaml_config[x])
    end
  end
end
