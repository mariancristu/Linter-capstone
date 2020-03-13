require 'yaml'

class Arguments
    attr_accessor :arguments, :files
    @priv_files = nil
    @initial_settings = nil

    def initialize(args)
        @arguments = args
        @valid_args = {
            init: 'initMethod',
            all: 'getAllFiles'
        }
        @files = []
        @priv_files = []
        @initial_settings = createSettings
    end

    def check_arguments
        if @arguments.length != 0
        @arguments.each do |arg|
            send(@valid_args[arg.to_sym]) if check(arg)
        end

        unless @priv_files.empty?
            @priv_files.each do |file|
                return "#{file} not found!" unless file_check(file)
                @files << file
            end
        end
        return true
    else
        raise ArgumentError, "Please use al least one argument!"
    end
    end

    protected
    def check(arg)
        sim = arg.gsub(/^\./,'')
        return true if @valid_args.has_key? sim.to_sym
        @priv_files << arg
        false
    end

    def file_check(arg)
        File.exist?(arg)
    end

    def initMethod
        File.open('jslint.yml','w') { |f|
            f.write(@initial_settings.to_yaml)
        }
    end

    def getAllFiles
        if File.exist?("jslint.yml") 
            @files << Dir.glob("#{Dir.getwd}/***/*.js") 
        else
            raise Exception, "Configuration file inexistent please run 'jslint init' first"   
        end
    end

    private
    def createSettings
        temp = {
            indentation: 2,
            variableNotUsed: true,
            whiteSpace: true
        }
        temp
    end
end