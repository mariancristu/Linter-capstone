module Loader
  class VariableNotUsed < ModuleSpec
    @counter = nil
    @errors = nil
    @variable = nil

    def initialize(value)
      super(value)
      @counter = -1
      @errors = []
      @variable = []
    end

    def check(line, *args)
      value ? start(line, args) : true
    end

    def name
      'VariableNotUsed'
    end

    protected

    def start(line, args)
      new_scope?(line)
      check_used(line, args)
      end_of_scope?(line)
    end

    def a_variable?(line)
      line.match(/[=()]/).nil? ? false : true
    end

    def get_all_variable(line)
      var = variable(line).select do |item|
        !item.nil? && !item.match(/\w+/).nil?
      end
      var = var.reject do |item|
        item.include? '.'
      end
      var = var.map(&:strip)
      var.map do |item|
        item.split(',').map(&:strip)
      end
    end

    def variable(line)
      var = []
      var << clean(line.match(/(?<=\()(.*?)(?=\))/))
      var << clean(line.match(/([a-z].*(?=\=))/))
      var << clean(line.match(/(?<=\=)\s?[a-z]*/))
      var
    end

    def clean(arr)
      arr.to_a[0]
    end

    def new_scope?(line)
      return if line.match(/{/).nil?

      @counter += 1
      @variable[@counter] = {}
    end

    def end_of_scope?(line)
      unless line.match(/}/).nil?
        pass_error
        @variable.delete_at(@counter)
        @counter -= 1 unless @counter < 1
        return false unless @actual.empty?
      end
      true
    end

    def check_used(line, args)
      get_all_variable(line).each do |x|
        x.each do |y|
          temp = false
          @variable.each do |h|
            h.keys.each do |key|
              next unless key == y

              h[y] = -1
              temp = true
            end
          end
          @variable[@variable.length - 1][y] = args[0] if (temp == false) && !args.empty?
        end
      end
    end

    def pass_error
      @expe = []
      @actual = []
      @variable[@counter].each do |h|
        @actual << [h[0], h[1].to_i + 1] if h[1].to_i >= 0
        @expe << 'not used'
      end
    end
  end
end
