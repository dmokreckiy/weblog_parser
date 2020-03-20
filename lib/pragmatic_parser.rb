# frozen_string_literal: true

require_relative 'base_parser'

class PragmaticParser < BaseParser
  private

  def parse_log
    processed_file = `awk '{print $1}' #{file_path} | sort | uniq -c | sort -r`

    formated_output = processed_file.each_line.map do |line|
      line.
        strip.
        split(' ').
        reverse.
        join(' ').
        concat(' unique views')
    end

    set_output(formated_output.join("\n"))
  end
end
