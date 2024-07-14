module ActiveAdminAssets
  # Catches active admin asset requests and serves them from the gem.
  class Middleware
    def initialize(app, *)
      @app = app
      @regexp = /\A#{ActiveAdminAssets.path}(.+)/
    end

    def call(env)
      serve(env[Rack::PATH_INFO]) || @app.call(env)
    end

    def serve(path)
      return unless asset_path = path[@regexp, 1]

      static_path = File.join(__dir__, 'assets', "#{asset_path}.gz")
      send_data(static_path)
    end

    # This could be made more efficient with sendfile,
    # perhaps after checking config.action_dispatch.x_sendfile_header
    def send_data(path)
      data = File.read(path)
      headers = {
        'cache-control'    => 'public, max-age=86400',
        'content-encoding' => 'gzip',
        'content-length'   => data.bytesize.to_s,
        'content-type'     => path['.css'] ? 'text/css' : 'text/javascript',
      }
      [200, headers, [data]]
    end
  end
end
