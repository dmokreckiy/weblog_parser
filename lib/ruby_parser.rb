# frozen_string_literal: true

require 'shellwords'
require_relative 'base_parser'

class RubyParser < BaseParser
  private

  attr_reader :page_views_results, :page_unique_views_results

  def parse_log
    initialize_views_results

    File.open(file.realpath) do |file|
      file.each_line do |line|
        log_line = Line.new(line)

        next unless log_line.valid?

        process_page_view(log_line)
        process_unique_view(log_line)
      end
    end

    set_output(
      formatted_page_views,
      formatted_unique_page_views
    )
  end

  def initialize_views_results
    @page_views_results = Hash.new(0)
    @page_unique_views_results = {}
  end

  def process_page_view(log_line)
    page_views_results[log_line.uri] = page_views_results[log_line.uri].succ
  end

  def process_unique_view(log_line)
    uri = log_line.uri
    ip = log_line.visitor_ip

    page_unique_views_results[uri] = {} unless page_unique_views_results[uri]
    page_unique_views_results[uri][ip] = true
  end

  def formatted_page_views
    formatted_results = [].tap do |array|
      page_views_results.each do |uri, views|
        array.push([uri, views, PAGE_VIEWS.strip])
      end
    end

    formatted_results.
      sort! { |element1, element2| element1[1] <=> element2[1] }.
      map! { |element| element.join(" ") }.
      reverse!.
      join("\n")
  end

  def formatted_unique_page_views
    formatted_results = [].tap do |array|
      page_unique_views_results.each do |uri, ip_hash|
        array.push([uri, ip_hash.keys.count, PAGE_UNIQUE_VIEWS.strip])
      end
    end

    formatted_results.
      sort! { |element1, element2| element1[1] <=> element2[1] }.
      map! { |element| element.join(" ") }.
      reverse!.
      join("\n")
  end
end
