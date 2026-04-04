[![Gem Version](https://badge.fury.io/rb/activeadmin_assets.svg)](http://badge.fury.io/rb/activeadmin_assets)
[![Build Status](https://github.com/jaynetics/activeadmin_assets/actions/workflows/main.yml/badge.svg)](https://github.com/jaynetics/activeadmin_assets/actions)
[![Coverage](https://codecov.io/github/jaynetics/activeadmin_assets/graph/badge.svg?token=7fCHVrCeFv)](https://codecov.io/github/jaynetics/activeadmin_assets)

# ActiveAdminAssets

This gem is for you if you want to be able to run [ActiveAdmin](https://github.com/activeadmin/activeadmin) v4+ without any asset setup, e.g.:

- no `cssbundling-rails` or `tailwindcss-rails`
- no `sprockets` or `propshaft`
- no `assets:precompile` or similar build steps

## Caveats

- This will prevent you from customizing ActiveAdmin's tailwind config, making theming more hacky.
- This will prevent you from using tailwind classes that are not used by ActiveAdmin itself.

## Installation

Add `activeadmin_assets` to your Gemfile.

## Usage

That's it 😁. If you want, you can configure the path to serve static assets from:

```ruby
ActiveAdminAssets.path = '/x/admin-assets' # default: '/active_admin_assets'
```

## How it works

Like the asset gems of old, this gem includes static copies of all assets that are required to run ActiveAdmin and injects them automatically.

The assets (CSS and JS) are generated automatically when testing or building the gem - see [./Rakefile](./Rakefile).

To make the assets available for any rails setup, the gem has a railtie which monkey-patches rails' asset path helpers ([`URLPatch`](./lib/activeadmin_assets/url_patch.rb)). This patch changes the CSS and JS paths that are rendered in ActiveAdmin views. The railtie also adds a middleware ([`Middleware`](./lib/activeadmin_assets/middleware.rb)). This middleware detects requests to these custom asset paths and responds to them by serving asset files from the gem.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jaynetics/activeadmin_assets.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
