# frozen_string_literal: true

require "ostruct"
require "net/http"
require "json"

module Nomics
  class Currency < OpenStruct
    def self.where(**conditions)
      uri = URI(Configuration.base_url)
      query = { key: Configuration.api_key }

      uri.path = "/v1/currencies/ticker"

      query[:ids] = conditions.delete(:ids).join(",")
      query[:convert] = conditions.delete(:convert)

      uri.query = URI.encode_www_form(query)

      response = Net::HTTP.get_response(uri)

      raise BadApiKey if response.is_a?(Net::HTTPUnauthorized)

      raise UnknownError unless
        response.is_a?(Net::HTTPSuccess) && response.content_type == "application/json"

      currencies = JSON.parse(response.body)

      currencies.map do |currency_details|
        Currency.new(currency_details).freeze
      end
    end
  end
end
