module Loader
    class ModuleSpec
        attr_accessor :value, :expe, :actual 

        @@reserved_words = [
            'class',
            'function',
            'static',
            'constructor'
        ]

        def initialize(value)
            @value = value
        end

        def check(line, *args)
            true
        end
    end
end