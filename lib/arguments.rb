require 'yaml'

class Arguments
  attr_reader :arguments, :files
  @priv_files = nil
  @initial_settings = nil
  @fi = nil

  def initialize(args)
    @arguments = args
    @valid_args = {
      init: 'init_method',
      all: 'all_files'
    }
    @files = []
    @priv_files = []
    @initial_settings = create_settings
    @fi = 'jslint.yml'
  end

  def check_arguments
    raise ArgumentError, 'Please use al least one argument!' if @arguments.empty?

    @arguments.each do |arg|
      send(@valid_args[arg.to_sym]) if check(arg)
    end

    unless @priv_files.empty?
      @priv_files.each do |file|
        return "#{file} not found!" unless file_check(file)

        @files << file
      end
    end
    true
  end

  protected

  def check(arg)
    sim = arg.gsub(/^\./, '')
    return true if @valid_args.key? sim.to_sym

    @priv_files << arg
    false
  end

  def file_check(arg)
    File.exist?(arg) && (File.extname(arg) == '.js')
  end

  def init_method
    File.open(@fi, 'w') do |f|
      f.write(@initial_settings.to_yaml)
    end
  end

  def all_files
    raise ArgumentError, 'Configuration file inexistent please run \'jslint init\' first' unless File.exist?(@fi)

    Dir.glob("#{Dir.getwd}/***/*.js").each do |file|
      @files << file
    end
  end

  private

  def create_settings
    temp = {
      Indentation: 2,
      VariableNotUsed: true,
      MaxLength: 120,
      ClassName: true
    }
    temp
  end
end
