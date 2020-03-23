# frozen_string_literal: true

module Utility
  def present?
    !blank?
  end

  def blank?
    respond_to?(:empty?) ? !!empty? : !self
  end
end

class String
  include Utility
end
