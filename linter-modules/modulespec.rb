module Loader
  class ModuleSpec
    attr_accessor :value, :expe, :actual

    @reserved_words = %w[
      class
      function
      static
      constructor
    ]

    def initialize(value)
      @value = value
    end

    def check(_line, _args)
      true
    end
  end
end
