module Loader
    class ModuleSpec
        attr_accessor :value
        @line = nil

        def initialize(value)
            @value = value
            @line = ''
        end

        def check(value)
            @line = value
        end
    end
end