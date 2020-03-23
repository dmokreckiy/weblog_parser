#!/usr/bin/env ruby

require 'monotonik'
require_relative 'lib/parser_dependencies'

Validator.new.call

puts '*'*20
puts 'Ruby Parser'
puts '*'*20

ruby_time = Monotonik.measure do
  ruby_parser = RubyParser.new(ARGV[0])
  ruby_parser.call
end

puts "Execution time - #{ruby_time.time}"

puts '*'*20
puts 'Unix Parser'
puts '*'*20

pragmatic_time = Monotonik.measure do
  pragmatic_parser = PragmaticParser.new(ARGV[0])
  pragmatic_parser.call
end

puts "Execution time - #{pragmatic_time.time}"

