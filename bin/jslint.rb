#!/usr/bin/env ruby

require_relative '../lib/arguments.rb'
require 'colorize'

argument = Arguments.new(ARGV)

begin
  result = argument.check_arguments
  puts result == true ? argument.files : result
rescue ArgumentError => e
  puts e.message.red
end
