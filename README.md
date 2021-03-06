# Csv::Indexer

Index a csv file by indentifying repeated rows based on column values. Output the indexed csv to a new file.

Using the `-m` flag, pass in a comma separated list of the fields for matches of row. For example if you want to match on phone, pass `-m phone`, or phone & email, `-m phone,email`.

The colums whose name contain the desired matches will be selected as the matching columns. Email1, Email2 ... ect, will match `-m email`.

An Id column is added to the CSV, the value of which represents the matching records. All records with the same id have matched based on the `-m` option given to the gem.

The resulting CSV file is named the same as the input file with the `_index` appended to it. It is created in the same directory as the input file.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csv-indexer'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install csv-indexer

## Usage

Local from executable:

```
./exe/csv-indexer -h
./exe/csv-indexer -i file -m column1,column2
```

Local from gem:

```
bundle exec rake install:local
csv-indexer -h
csv-indexer -i file -m column1,column2
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/csv-indexer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/csv-indexer/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Csv::Indexer project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/csv-indexer/blob/master/CODE_OF_CONDUCT.md).
