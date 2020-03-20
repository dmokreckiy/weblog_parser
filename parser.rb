#!/usr/bin/env ruby

require_relative 'lib/validator'
require_relative 'lib/pragmatic_parser'

Validator.new.call
parser = PragmaticParser.new(ARGV[0])
parser.call
