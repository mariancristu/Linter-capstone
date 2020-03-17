module Loader
  class Indentation < ModuleSpec
    attr_reader :counter

    def initialize(value)
      super(value)
      @counter = 0
      @expe = 0
    end

    def check(line, _args)
      valid?(line)
    end

    def name
      'Style/Indentation'
    end

    protected

    def valid?(line)
      return true if no_text?(line)

      @expe = @counter
      decrease unless close_curly?(line).nil?
      t_res = white_spaces(line) == @counter
      increase unless open_curly?(line).nil?
      raise RangeError if @counter.negative?

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

    def open_curly?(line)
      line.match(/{/)
    end

    def close_curly?(line)
      line.match(/}/)
    end

    def white_spaces(line)
      @actual = line.match(/\s*/)[0].length
      @actual
    end

    def no_text?(line)
      line.match(/\s*/)[0] == "\n"
    end
  end
end
