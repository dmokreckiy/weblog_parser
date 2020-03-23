# frozen_string_literal: true

require_relative 'base_parser'

class PragmaticParser < BaseParser
  private

  def parse_log
    set_output(most_page_views, most_pages_unique_views)
  end

  def most_page_views
    processed_file = `awk '{print $1}' #{file_path} | sort | uniq -c | sort -nr`

    format_output(processed_file, PAGE_VIEWS)
  end

  def most_pages_unique_views
    processed_file = `awk '{print$2, $1}' #{file_path} | sort -u | awk '{print$2}' | sort | uniq -c | sort -r`

    format_output(processed_file, PAGE_UNIQUE_VIEWS)
  end

  def format_output(results, views_string)
    results_string_array = results.each_line.map do |line|
      line.
        strip.
        split(' ').
        reverse.
        join(' ').
        concat("#{views_string}")
    end

    results_string_array.join("\n")
  end
end
