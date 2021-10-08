# Nomics

An incomplete wrapper around [nomics.com](https://nomics.com/docs/) API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nomics'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install nomics

## Direct use via command line scripts

### Currency info using bin/currency script

Example:

```
./bin/currency -k f0f1662874adc51af4be4d4aa68c056fec02fea2 BTC
```

This will output currency details in somewhat readable yaml format:

```yaml
id: BTC
currency: BTC
symbol: BTC
name: Bitcoin
logo_url: https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/btc.svg
status: active
price: '54812.75095161'
<...rest of output is skipped...>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake spec` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem`
file to [rubygems.org](https://rubygems.org).
