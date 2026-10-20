# Meibo

Meibo is a ruby library for OneRoster CSV Binding Japan Profile.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'meibo'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install meibo

## Usage

```rb
# First, choose OneRoster profile
Meibo.default_profile = Meibo::Profiles["学習eポータル標準モデル Ver. 3.00"]

# Then open OneRoster file
file = File.open('oneroster.zip')
Meibo::Roster.from_file(file) do |roster|
  roster.users.each do |user|
    import_user_to_your_system(user)
  end
end
```

### Reject duplicate userMasterIdentifier values

Duplicate `userMasterIdentifier` values are allowed by default. To restore the
validation used before version 0.29, create a profile with
`allow_duplicate_user_master_identifiers: false`:

```ruby
base_profile = Meibo::Profiles["学習eポータル標準モデル Ver. 3.00"]
profile = Meibo::Profile.new(
  builders: base_profile.builders,
  data_models: base_profile.data_models,
  data_set: base_profile.data_set,
  manifest_properties: base_profile.manifest_properties,
  allow_duplicate_user_master_identifiers: false
)

roster = Meibo::Roster.from_file("oneroster.zip", profile: profile)
```

This setting rejects duplicates across all users in a roster, regardless of
organization or role, with `Meibo::Error, "userMasterIdentifierが重複しています"`.
As before version 0.29, `nil` values are ignored by this duplicate check.
Other validation rules are unchanged.

The same setting applies to `Meibo::Roster.from_buffer` and
`roster.check_semantically_consistent`. To use the configured profile by default
in an application, set `Meibo.default_profile = profile` during initialization.
Profiles with `allow_duplicate_user_master_identifiers: true`, including the
built-in profiles, continue to allow duplicates.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hanachin/meibo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/hanachin/meibo/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Meibo project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/hanachin/meibo/blob/main/CODE_OF_CONDUCT.md).
