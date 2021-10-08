# frozen_string_literal: true

RSpec.describe Nomics::Currency do
  before do
    Nomics::Configuration.base_url = "https://nomics.dev/"
    Nomics::Configuration.api_key = "ffffffff-ffff-ffff-ffff-ffffffffffff"
  end

  describe ".where" do
    it "uses the configured base url" do
      Nomics::Configuration.base_url = "https://example.org/"

      stub_request(:any, /https:\/\/example\.org\.*/).
        to_return(body: "[]", headers: { "Content-Type" => "application/json"})

      described_class.where(ids: ["BTC"])
    end

    it "uses the configured api key" do
      Nomics::Configuration.api_key = "e78d147a-e04e-438d-b0c6-a36ec93403a8"

      stub_request(:any, /https:\/\/nomics\.dev.*/).
        with(query: hash_including(key: "e78d147a-e04e-438d-b0c6-a36ec93403a8")).
        to_return(body: "[]", headers: { "Content-Type" => "application/json"})

      described_class.where(ids: ["BTC"])
    end

    it "requests currency tickers specified in ids argument" do
      stub_request(:any, /https:\/\/nomics\.dev.*/).
        with(query: hash_including(ids: "ACOIN,BCOIN")).
        to_return(body: "[]", headers: { "Content-Type" => "application/json"})

      described_class.where(ids: ["ACOIN", "BCOIN"])
    end
  end
end
