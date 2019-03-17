# AddressSearch

## Usage

### Search
```ruby
$ bundle install
# bundle exec ./scripts/search.rb [input file] [format(csv or json)] [keywords]
$ bundle exec ./scripts/search.rb 26KYOUTO.CSV csv 渋谷 なぎさ 東京
$ bundle exec ./scripts/search.rb all.json json 原宿 表参道
```

### Dump
```ruby
$ bundle install
$ bundle exec ./scripts/dump.rb KEN_ALL.CSV all.json
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
