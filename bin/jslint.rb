#!/usr/bin/env ruby

require_relative '../lib/arguments.rb'
require_relative '../lib/loader.rb'
require_relative '../lib/ErrorHolder.rb'
require 'colorize'
require 'tty-font'
require 'tty-progressbar'

on_complete = lambda do |er|
  if er.empty?
    puts "No error found!".green 
  else
    puts "Errors found on files...".red
    puts ""
    er.each do |e|
      if !e.actual.is_a? Array
        puts e.filename.light_red + ":" + 
        (e.line_nr + 1).to_s + " - " + 
        e.linter_name.get_name.blue
        puts "\"#{e.line_text.strip}\" ".blue
        puts "expected: " + e.expe.to_s.red

        puts "actual: " +
             e.actual.to_s.red
      else
        e.actual.each do |act|
          puts e.filename.light_red + ":" + 
               act[1].to_s + " - " + 
               e.linter_name.get_name.blue
          puts "expected: " + act[0].red
          puts "actual: " + e.expe[0].red
      end
    end
    puts ""
    end
    puts "Found #{er.length.to_s.red} errors!"
  end
end

on_linter_created = lambda do |linters|
  puts "Linters based on configuration files:".green
  linters.each do |lint|
    puts lint.get_name.cyan
  end
  puts ""
end

on_files_load = lambda do |files|
  files.each do |file|
    puts file.blue
  end
  puts ""
end

def show_title
  font = TTY::Font.new('3d')
  puts font.write("JSLint", letter_spacing: 1)
end

def start(callback, on_linter_created, on_files_load)
  argument = Arguments.new(ARGV)
  errors = []
begin
  show_title
  result = argument.check_arguments
  raise result unless result == true
  on_files_load.call(argument.files)
  prog = TTY::ProgressBar.new("Checking [:bar] [:total%]", total: 100)
  prog.width = 50
  
  argument.files.each do |file|
    linters = Loader.create_linters
    on_linter_created.call(linters)

    File.open(file).each_with_index do |line, index|
      linters.each do |lint|
        unless lint.check(line, index)
          errors << ErrorHolder.new(file, lint, index, line, lint.expe, lint.actual)
        end
      end
      prog.advance(100 / (argument.files.length * linters.length))
    end
  end
  puts ""
  callback.call(errors)
rescue ArgumentError => e
  puts e.full_message 
end
end


start(on_complete,on_linter_created, on_files_load)