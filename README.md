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

For starters do check out the available options via:

```
./bin/currency --help
```

#### Basic Usage

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

#### Limiting/filtering information to display

The output can be limited to specific attributes, for example:

```
./bin/currency -k f0f1662874adc51af4be4d4aa68c056fec02fea2 --show=symbol,name,circulating_supply,max_supply,price BTC ETH
```

This will produce output:

```yaml
---
symbol: BTC
name: Bitcoin
circulating_supply: '18838031'
max_supply: '21000000'
price: '54654.12584170'


---
symbol: ETH
name: Ethereum
circulating_supply: '117844113'
price: '3633.92244355'
```

#### Specifying base/fiat currency for price conversion

Example of BTC price USD:

```
./bin/currency -k f0f1662874adc51af4be4d4aa68c056fec02fea2 --show=id,name,price --convert=USD BTC
```

Output:

```yaml
---
id: BTC
name: Bitcoin
price: '54721.17866894'
```

And then in GBP:

```
./bin/currency -k f0f1662874adc51af4be4d4aa68c056fec02fea2 --show=id,name,price --convert=GBP BTC
```

Output:

```yaml
---
id: BTC
name: Bitcoin
price: '40182.43550499'
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
