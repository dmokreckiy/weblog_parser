# frozen_string_literal: true

require 'pathname'
require 'shellwords'

class BaseParser
  PAGE_VIEWS = ' page views'
  PAGE_UNIQUE_VIEWS = ' unique page views'

  attr_reader :file_path, :file, :output

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
    puts 'Most page views'
    puts output[:views]
    puts 'Most unique views'
    puts output[:unique_views]
  end

  def set_output(most_views, most_unique_views)
    @output ||= {
      views: most_views,
      unique_views: most_unique_views
    }
  end
end
