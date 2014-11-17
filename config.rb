# Set directories
set :css_dir,      'stylesheets'
set :js_dir,       'javascripts'
set :images_dir,   'images'
set :partials_dir, 'partials'

set :debug_assets, true

page '/404.html', layout: false

configure :development do
  # Reload the browser automatically whenever files change
  activate :livereload, no_swf: true

  # Deploy to S3
  activate :s3_sync do |options|
    options.bucket = 'workbeer.co'
  end

  caching_policy 'image/x-icon',           expires: one_year_from_now
  caching_policy 'image/jpeg',             expires: one_year_from_now
  caching_policy 'image/png',              expires: one_year_from_now
  caching_policy 'text/css',               expires: one_year_from_now
  caching_policy 'application/javascript', expires: one_year_from_now
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use GZIP compression
  activate :gzip

  # Compress images
  activate :imageoptim do |options|
    options.pngout_options = false
    options.advpng_options = false
  end
end

def one_year_from_now
  Time.now + (365.25 * 24 * 3600)
end
