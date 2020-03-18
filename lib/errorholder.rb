class ErrorHolder
  attr_reader :filename, :linter_name, :line_nr, :line_text, :column, :expe, :actual

  def initialize(f_name, l_name, l_nr, l_text, expe, actual, l_col = 0)
    @filename = f_name
    @linter_name = l_name
    @line_nr = l_nr
    @line_text = l_text
    @column = l_col
    @expe = expe
    @actual = actual
  end
end
