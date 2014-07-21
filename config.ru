require 'rack'
require 'builder'
require 'rack-rewrite'

app = Rack::Builder.new do
  use Rack::Rewrite do
    rewrite '/', '/index.html'
  end
  use Rack::CommonLogger, STDOUT
  run Rack::Directory.new [Dir.pwd, 'site'].join('/')
end

Rack::Handler::Thin.run app
