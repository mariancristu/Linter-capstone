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
  linters = Loader.create_linters
  argument.files.each do |file|
    File.open(file).each do |line|
      #Aici se instampla totul
      linters.each do |lint|
        lint.check(line)
      end
    end
  end
rescue ArgumentError => e
  puts e.full_message
end
