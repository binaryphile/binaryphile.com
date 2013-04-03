require 'rack'
require 'ruhoh'
require 'rack-livereload'
use Rack::LiveReload, no_swf: true, min_delay: 500
run Ruhoh::Program.preview

# To preview your blog in "production" mode:
# run Ruhoh::Program.preview(:env => 'production')
