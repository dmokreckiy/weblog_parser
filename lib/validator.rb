# frozen_string_literal: true

class Validator
  attr_reader :opts

  def initialize
    @opts = ARGV
  end

  def call
    validate_empty_args
    validate_single_file_argument
    validate_file_existance
  end

  private

  def validate_empty_args
    return unless opts.size.zero?

    puts 'Single file name/path is required as an argument'
    exit(1)
  end

  def validate_single_file_argument
    return if opts.size == 1

    puts 'Only one file should be provided'
    exit(1)
  end

  def validate_file_existance
    return if Pathname.new(File.expand_path(opts.first)).exist?

    puts "No such file exists - #{opts.first}"
    exit(1)
  end
end
