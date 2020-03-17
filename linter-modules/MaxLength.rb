module Loader
    class MaxLength < ModuleSpec
        
        def initialize(value)
            super(value)
            @expe = nil
        end

        def check(line, *args)
            start(line)
        end

        def get_name
            'Style/MaxLength'
        end

        protected
        def start(line)
            unless get_length(line)
                @expe = @value
                @actual = line.length
                return false
            end
            true
        end

        def get_length(line)
            line.length <= @value ? true : false 
        end
    end
end