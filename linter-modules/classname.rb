module Loader
  class ClassName < ModuleSpec
    def initialize(line)
      super(line)
    end

    def check(line, _args)
      @value ? start(line) : true
    end

    def name
      'Style/ClassName'
    end

    protected

    def start(line)
      if check_keyword(line)
        name = extract_name(line)[0]
        l_case = name.match(/^[A-Z]/)
        # return name.nil? ? false : true
        if l_case.nil?
          @actual = name
          @expe = name.capitalize
          return false
        end
      end
      true
    end

    def check_keyword(line)
      line.match(/(class)/).nil? ? false : true
    end

    def extract_name(line)
      line.match(/(?<=class\s)\w*/)
    end
  end
end
