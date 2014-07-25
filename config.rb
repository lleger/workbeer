# Set directories
set :css_dir,      'stylesheets'
set :js_dir,       'javascripts'
set :images_dir,   'images'
set :partials_dir, 'partials'

configure :development do
  # Reload the browser automatically whenever files change
  activate :livereload, no_swf: true

  # Deploy to S3
  activate :s3_sync do |s3_sync|
    s3_sync.bucket = 'workbeer.co'
  end
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
  activate :imageoptim
end
