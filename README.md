[![Gem Version](https://badge.fury.io/rb/activeadmin_assets.svg)](http://badge.fury.io/rb/activeadmin_assets)
[![Build Status](https://github.com/jaynetics/activeadmin_assets/actions/workflows/main.yml/badge.svg)](https://github.com/jaynetics/activeadmin_assets/actions)
[![Coverage](https://codecov.io/github/jaynetics/activeadmin_assets/graph/badge.svg?token=7fCHVrCeFv)](https://codecov.io/github/jaynetics/activeadmin_assets)

# ActiveAdminAssets

This gem is for you if you want to be able to run [ActiveAdmin](https://github.com/activeadmin/activeadmin) v4+ without any asset setup, e.g.:

- no `cssbundling-rails` or `tailwindcss-rails`
- no `sprockets` or `propshaft`
- no `assets:precompile` or similar build steps

Like the asset gems of old, it includes static copies of all required assets and injects them automatically.

## Caveats

- This will prevent you from customizing ActiveAdmin's tailwind config, making theming more hacky.
- This will prevent you from using tailwind classes that are not used by ActiveAdmin itself.
- This might break with ActiveAdmin updates, though I don't consider it likely so its not version-locked yet.

## Installation

Add `activeadmin_assets` to your Gemfile.

## Usage

That's it 😁. If you want, you can configure the path to serve static assets from:

```ruby
ActiveAdminAssets.path = '/x/admin-assets' # default: '/active_admin_assets'
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jaynetics/activeadmin_assets.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
