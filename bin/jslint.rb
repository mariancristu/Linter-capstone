#!/usr/bin/env ruby

require_relative '../lib/arguments.rb'
require_relative '../lib/loader.rb'
require_relative '../lib/ErrorHolder.rb'
require 'colorize'

argument = Arguments.new(ARGV)
errors = []

begin
  result = argument.check_arguments
  # puts result == true ? argument.files : result
  argument.files.each do |file|
    linters = Loader.create_linters
    File.open(file).each_with_index do |line, index|
      #Aici se instampla totul
      # p index
      linters.each do |lint|
        unless lint.check(line, index)
          errors << ErrorHolder.new(file, lint, index, line, lint.expe, lint.actual)
        end
      end
    end
  end
rescue ArgumentError => e
  puts e.full_message 
end

errors.each do |x|
  puts x.actual
end

# p a = []

# a[0] = {}

# p a[0] = {eu:4}
# p a[0][:tu]= 4

# p a[0]

# p "this.height = pulacxxcxc;".match(/\w+\.\w+\s*=\s*\w+/)

# a =  "this.height = pula;".split('=').map(&:strip)
# b = a.select do |x|
#   !x.include? '.'
# end

# p b