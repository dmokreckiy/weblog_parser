# frozen_string_literal: true

require 'shellwords'
require_relative 'base_parser'

class RubyParser < BaseParser
  private

  def parse_log
    raise NotImplementedError

    # parsed_entries = Hash.new(0)

    # File.open(file.realpath) do |file|
    #   parsed_entries.tap do |default_hash|
    #     file.each_line do |line|
    #       uri = line.split(' ').first
    #       default_hash[uri].succ

    #     end
    #   end
    # end

    # set_output(formated_output.join("\n"))
  end
end
