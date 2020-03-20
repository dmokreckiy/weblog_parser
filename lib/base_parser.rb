# frozen_string_literal: true

require 'pathname'
require 'shellwords'

class BaseParser
  attr_reader :file_path, :file

  def initialize(file_path)
    @file_path = file_path
  end

  def call
    fetch_filepath

    parse_log

    print_result
  end

  private

  def fetch_filepath
    @file = Pathname.new(File.expand_path(file_path))
    @file_path = Shellwords.shellescape(@file.realpath)
  rescue StandardError
    puts 'File absolute path can not be determined'
    exit(1)
  end

  def parse_log
    raise NotImplementedError
  end

  def print_result
    puts output
  end

  def set_output(formated_result)
    @output ||= formated_result
  end

  def output
    @output
  end
end
