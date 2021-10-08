# frozen_string_literal: true

require_relative "nomics/version"
require_relative "nomics/currency"

module Nomics
  class Error < StandardError; end

  class BadApiKey < Error; end

  class UnknownError < Error; end
end
