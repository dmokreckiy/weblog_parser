# frozen_string_literal: true

require 'ipaddr'

class Line
  attr_reader :line, :uri, :visitor_ip

  def initialize(entrie)
    @line = entrie
    @uri, @visitor_ip = entrie&.split(' ')
  end

  def valid?
    return true if uri_valid? && visitor_ip_valid?

    bad_line_warning
  end

  private

  def uri_valid?
    uri&.present? && uri&.start_with?('/')
  end

  def visitor_ip_valid?
    visitor_ip&.present?
    # && IPAddr.new(visitor_ip).ipv4? - disabled as demo log has non valid entries
  # rescue IPAddr::InvalidAddressError
  #   false
  end

  def bad_line_warning
    puts "Invalid log entrie - \"#{line}\""
  end
end
