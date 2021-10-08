# frozen_string_literal: true

require "active_support/configurable"

module Nomics
  class Configuration
    include ActiveSupport::Configurable

    config_accessor :api_key
    config_accessor :base_url do
      "https://api.nomics.com/"
    end
  end
end
