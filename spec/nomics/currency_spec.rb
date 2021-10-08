# frozen_string_literal: true

RSpec.describe Nomics::Currency do
  before do
    Nomics::Configuration.base_url = "https://nomics.dev/"
    Nomics::Configuration.api_key = "ffffffff-ffff-ffff-ffff-ffffffffffff"
  end

  describe ".where" do
    it "uses the configured base url" do
      Nomics::Configuration.base_url = "https://example.org/"

      stub_request(:any, %r{https://example\.org\.*})
        .to_return(body: "[]", headers: { "Content-Type" => "application/json" })

      described_class.where(ids: ["BTC"])
    end

    it "uses the configured api key" do
      Nomics::Configuration.api_key = "e78d147a-e04e-438d-b0c6-a36ec93403a8"

      stub_request(:any, %r{https://nomics\.dev.*})
        .with(query: hash_including(key: "e78d147a-e04e-438d-b0c6-a36ec93403a8"))
        .to_return(body: "[]", headers: { "Content-Type" => "application/json" })

      described_class.where(ids: ["BTC"])
    end

    it "handles 401 unauthorized response code" do
      stub_request(:any, %r{https://nomics\.dev.*})
        .to_return(body: "Unauthorized", status: 401)

      expect { described_class.where(ids: ["BTC"]) }.to raise_error(Nomics::BadApiKey)
    end

    it "handles non-200 response codes as errors" do
      stub_request(:any, %r{https://nomics\.dev.*})
        .to_return(body: "I'm a teapot", status: 418)

      expect { described_class.where(ids: ["BTC"]) }.to raise_error(Nomics::UnknownError)
    end

    it "requests currency tickers specified in ids argument" do
      stub_request(:any, %r{https://nomics\.dev.*})
        .with(query: hash_including(ids: "ACOIN,BCOIN"))
        .to_return(body: "[]", headers: { "Content-Type" => "application/json" })

      described_class.where(ids: %w[ACOIN BCOIN])
    end

    it "returns empty list if given currency ticker does not exist" do
      stub_request(:any, %r{https://nomics\.dev.*})
        .to_return(body: "[]", headers: { "Content-Type" => "application/json" })

      expect(described_class.where(ids: ["YOY"])).to eq []
    end

    it "verifies content type before attempting to parse json" do
      stub_request(:any, %r{https://nomics\.dev.*})
        .to_return(body: "Hmmm....")

      expect { described_class.where(ids: ["BTC"]) }.to raise_error(Nomics::UnknownError)
    end

    it "parses json and returns currency object" do
      stub_request(:any, %r{https://nomics\.dev.*})
        .to_return(body: '[{"id":"BTC","name":"Bitcoin"}]', headers: { "Content-Type" => "application/json" })

      coins = described_class.where(ids: ["BTC"])

      expect(coins).to contain_exactly(have_attributes(id: "BTC", name: "Bitcoin"))
    end
  end
end
