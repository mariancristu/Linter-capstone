module Loader
    class Indentation < ModuleSpec
        attr_reader :counter

        def initialize(value)
            super(value)
            @counter = 0
            @expe = 0
        end

        def check(line, *args)
            is_valid(line)
        end

        def get_name
            "Style/Indentation"
        end

        protected
        
        def is_valid(line)
            return true if is_no_text(line)
            @expe = @counter
            decrease unless is_close_curly(line).nil?
            t_res = white_spaces(line) == @counter ? true : false
            increase unless is_open_curly(line).nil?
            raise RangeError if @counter < 0
            t_res
        end

        private
        def decrease
            @counter -= @value
            @expe = @counter
        end

        def increase 
            @counter += @value
        end

        def is_open_curly(line)
            line.match(/{/)
        end

        def is_close_curly(line)
            line.match(/}/)
        end

        def white_spaces(line)
            @actual = line.match(/\s*/)[0].length
            @actual
        end

        def is_no_text(line)
            line.match(/\s*/)[0] == "\n"
        end
    end
end